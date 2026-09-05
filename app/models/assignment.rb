class Assignment < ApplicationRecord
  belongs_to :equipment
  belongs_to :user

  attr_accessor :filter_category_id

  validates :assigned_at,  presence: true
  validates :condition_in, presence: true

  validate :equipment_must_be_available, on: :create

  after_create  :mark_equipment_assigned
  after_update  :mark_equipment_available, if: :just_returned?

  scope :active,   -> { where(returned_at: nil) }
  scope :returned, -> { where.not(returned_at: nil) }

  def active?
    returned_at.nil?
  end

  def equipment_clean_name
    return nil unless equipment
    asset = equipment.asset_tag.present? ? "#{equipment.asset_tag} · " : ""
    "#{asset}#{[equipment.brand, equipment.model].select(&:present?).join(' ')}"
  end

  private

  def equipment_must_be_available
    if equipment.present? && equipment.status != "available"
      errors.add(:equipment, "is not available (current status: #{equipment.status})")
    end
  end

  def mark_equipment_assigned
    equipment.update!(status: :assigned)
  end

  def mark_equipment_available
    equipment.update!(status: :available)
  end

  def just_returned?
    returned_at_previously_changed? && returned_at.present?
  end
end