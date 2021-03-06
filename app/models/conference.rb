class Conference < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_and_belongs_to_many :languages
  has_many :conference_editions, dependent: :destroy

  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  DOMAIN_REGEX = /\A[A-Z0-9.-]+\.[A-Z]+\z/i

  # Validations
  validates :name, presence: true
  validates :subdomain, presence: true, uniqueness: true, length: { maximum: 60 }
  validates :custom_domain, uniqueness: true, length: { maximum: 60 }, format: DOMAIN_REGEX, if: :custom_domain?
  validates :owner, presence: true
  validates :email, presence: true, format: EMAIL_REGEX
  validates :languages, presence: true

  # Nested attributes
  accepts_nested_attributes_for :conference_editions
end
