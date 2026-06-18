class OnboardingMailer < ApplicationMailer
  def onboarding_email(onboarding_request, pdf_content)
    @onboarding = onboarding_request
    @user       = onboarding_request.user

    attachments["onboarding_#{@user.full_name.parameterize}.pdf"] = {
      mime_type: "application/pdf",
      content:   pdf_content
    }

    mail(
      to:      ENV.fetch("ONBOARDING_EMAIL_TO", "sargaez@interwf.com"),
      subject: "Onboarding Request — #{@user.full_name}"
    )
  end
end