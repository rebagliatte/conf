class User < ActiveRecord::Base
  attr_accessible :name, :nickname, :email, :image, :role

  has_many :identities
  has_one :speaker
  has_and_belongs_to_many :manageable_conferences, class_name: 'Conference'
  has_many :owned_conferences, class_name: 'Conference', foreign_key: :owner_id

  ROLES = %w( user admin superadmin )

  # Validations
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
end
