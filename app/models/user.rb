class User < ActiveRecord::Base
  attr_accessible :name, :nickname, :email, :image, :role

  has_many :identities
  has_one :speaker
  has_and_belongs_to_many :manageable_conferences, class_name: 'Conference'
  has_many :owned_conferences, class_name: 'Conference', foreign_key: :owner_id

  ROLES = %w( user admin superadmin )

  validates :name, presence: true
  validates :role, inclusion: { in: ROLES }

  def superadmin?
    self.role == 'superadmin'
  end

  def admin?
    self.role == 'admin'
  end

  def self.create_with_omniauth(info)
    create!(name: info['name'], nickname: info['nickname'], email: info['email'], image: info['image'])
  end

  def manageable_conference_editions
    conference_editions = []
    Conference.where(owner_id: id).each do |c|
      conference_editions << c.conference_editions
    end
    conference_editions.flatten
  end
end
