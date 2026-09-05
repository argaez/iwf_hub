class Avo::Actions::RetireEquipment < Avo::BaseAction
  self.name = "Retire Equipment"
  self.confirm_button_label = "Retire"

  def fields
    field :retirement_reason, as: :select, name: "Reason",
      options: {
        "Donation"     => "donation",
        "Disposal"     => "disposal",
        "Spare Parts"  => "spare_parts",
        "Theft / Loss" => "theft_loss",
        "Obsolescence" => "obsolescence"
      },
      include_blank: "Select a reason..."

    field :retirement_date, as: :date, name: "Retirement Date"

    field :notes, as: :textarea, name: "Notes",
      help: "Optional — additional details about the retirement"
  end

  def handle(query:, fields:, current_user:, resource:, **args)
    if fields[:retirement_reason].blank?
      return error "You must select a reason for retirement."
    end

    if fields[:retirement_date].blank?
      return error "You must indicate the retirement date."
    end

    retired  = 0
    skipped  = []

    query.each do |equipment|
      if equipment.status == "assigned"
        skipped << equipment.display_name
        next
      end

      equipment.update!(
        status:            "retired",
        retirement_reason: fields[:retirement_reason],
        retirement_date:   fields[:retirement_date],
        notes:             [equipment.notes, fields[:notes]].compact_blank.join(" | ")
      )
      retired += 1
    end

    if skipped.any?
      error "Could not retire: #{skipped.join(', ')} — unassign them first."
    end

    if retired > 0
      succeed "#{retired} equipment item(s) retired successfully."
    end
  end
end