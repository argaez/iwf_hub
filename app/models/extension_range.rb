class ExtensionRange < ApplicationRecord
  belongs_to :tenant, optional: true

  validates :range_start, presence: true
  validates :range_end, presence: true
  validates :label, presence: true

  validate :range_start_less_than_end

  private

  def range_start_less_than_end
    return if range_start.blank? || range_end.blank?

    if range_start >= range_end
      errors.add(:range_end, "debe ser mayor que el inicio del rango")
    end
  end
end