module Avo
  class UsersController < ResourcesController
    after_action :process_onboarding,
      only: [:create],
      if: -> { @record.persisted? && params[:onboarding].present? && params[:onboarding][:enabled] == "1" }

    private

    def process_onboarding
      ob_params = params.require(:onboarding).permit(
        :enabled, :request_date, :start_date,
        :new_computer, :pc_name_or_previous_owner, :pc_asset_tag,
        :remote_access_needed, :new_remote_user, :previous_remote_user, :remote_department,
        :applications_other, :existing_phone, :extension_id,
        :notes, applications: [], distribution_lists: []
      )

      onboarding = OnboardingRequest.new(
        user:                      @record,
        tenant:                    @record.tenant,
        request_date:              ob_params[:request_date].presence || Date.today,
        start_date:                @record.hire_date,
        new_computer:              ob_params[:new_computer] == "1",
        pc_name_or_previous_owner: ob_params[:pc_name_or_previous_owner],
        pc_asset_tag:              ob_params[:pc_asset_tag],
        remote_access_needed:      ob_params[:remote_access_needed] == "1",
        new_remote_user:           ob_params[:new_remote_user] == "1",
        previous_remote_user:      ob_params[:previous_remote_user],
        remote_department:         ob_params[:remote_department],
        applications:              ob_params[:applications] || [],
        applications_other:        ob_params[:applications_other],
        existing_phone:            ob_params[:existing_phone] == "1",
        extension_id:              ob_params[:extension_id].presence,
        distribution_lists:        ob_params[:distribution_lists] || [],
        notes:                     ob_params[:notes]
      )

      ActsAsTenant.with_tenant(@record.tenant) do
        if onboarding.save
          begin
            pdf_content = OnboardingPdfGenerator.new(onboarding).generate
            onboarding.pdf_document.attach(
              io:           StringIO.new(pdf_content),
              filename:     "onboarding_#{@record.full_name.parameterize}_#{Date.today}.pdf",
              content_type: "application/pdf"
            )
            OnboardingMailer.onboarding_email(onboarding, pdf_content).deliver_later
          rescue => e
            Rails.logger.error "[Onboarding] PDF/email failed: #{e.class} — #{e.message}\n#{e.backtrace.first(5).join("\n")}"
          end
        else
            Rails.logger.error "[Onboarding] Save failed for user #{@record.id}: #{onboarding.errors.full_messages.inspect}"
        end
      end

      if ob_params[:extension_id].present?
        ActsAsTenant.without_tenant do
          Extension.find_by(id: ob_params[:extension_id])&.update(user: @record)
        end
      end
    end
  end
end