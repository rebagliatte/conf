class User < ActiveRecord::Base
  attr_accessible :name, :nickname, :email, :image, :role

  has_many :identities
  has_one :speaker
  has_and_belongs_to_many :manageable_editions, class_name: 'ConferenceEdition'
  has_many :owned_conferences, class_name: 'Conference', foreign_key: :owner_id

  ROLES = %w( user admin )

  # Validations
  validates :name, presence: true
  validates :role, inclusion: { in: ROLES }

  def admin?
    self.role == 'admin'
  end

  def self.create_with_omniauth(info)
    create!(name: info['name'], nickname: info['nickname'], email: info['email'], image: info['image'])
  end

  def manageable_edition_ids
    @manageable_edition_ids ||= manageable_editions.pluck(:id)
  end

  def readable_conference_ids
    @readable_conference_ids ||= manageable_editions.pluck(:conference_id).uniq
  end
end
