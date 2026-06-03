class Assignment < ApplicationRecord
  belongs_to :equipment
  belongs_to :user

  validates :assigned_at, presence: true
  validates :condition_in, presence: true

  scope :active, -> { where(returned_at: nil) }
  scope :returned, -> { where.not(returned_at: nil) }

  after_create :mark_equipment_assigned
  after_update :mark_equipment_available, if: :returned?

  def returned?
    returned_at.present? && returned_at_previously_was.nil?
  end

  private

  def mark_equipment_assigned
    equipment.update!(status: :assigned)
  end

  def mark_equipment_available
    equipment.update!(status: :available)
  end
end