class Department < ApplicationRecord
  belongs_to :tenant, optional: true
  has_many :users, dependent: :nullify

  validates :name, presence: true
end