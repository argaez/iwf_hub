class Extension < ApplicationRecord
  belongs_to :tenant
  belongs_to :user, optional: true

  validates :number, presence: true, uniqueness: { scope: :tenant_id }

  scope :available, -> { where(user_id: nil) }
  scope :in_use,    -> { where.not(user_id: nil) }

  def available? = user_id.nil?
  def to_s = number.to_s
end
