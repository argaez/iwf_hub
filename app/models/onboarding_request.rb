class OnboardingRequest < ApplicationRecord
  acts_as_tenant :tenant

  belongs_to :user
  belongs_to :tenant
  belongs_to :extension, optional: true

  has_one_attached :pdf_document

  APPLICATIONS = [
    "MS Office",
    "Outlook",
    "Magaya Cloud",
    "Google Chrome",
    "Adobe Acrobat Reader",
    "Wise",
    "DacEasy"
  ].freeze

  DISTRIBUTION_LISTS = [
    "ltlpricing@interwf.com",
    "invoicing@interwf.com",
    "interworld_bi@interwf.com",
    "importsgroup@interworldfreight.com",
    "imports@itcline.com",
    "hyatt@laserfreight.com",
    "imports@interwf.com",
    "pricing@interwf.com"
  ].freeze

  validates :request_date, presence: true
end