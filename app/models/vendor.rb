class Vendor < ApplicationRecord
  belongs_to :tenant, optional: true
  has_many :equipment, dependent: :nullify

  validates :name, presence: true
end