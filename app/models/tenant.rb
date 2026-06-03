class Tenant < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :departments, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :suppliers, dependent: :destroy
  has_many :equipment_categories, dependent: :destroy
  has_many :equipment, dependent: :destroy

  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: true

  before_validation :normalize_subdomain

  private

  def normalize_subdomain
    self.subdomain = subdomain.to_s.downcase.strip.gsub(/[^a-z0-9\-]/, "-")
  end
end