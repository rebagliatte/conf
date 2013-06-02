class User < ActiveRecord::Base
  attr_accessible :name, :nickname, :email, :image, :role

  has_many :identities
  has_one :speaker
  has_and_belongs_to_many :conferences
  has_many :conferences

  ROLES = %w( user admin )

  validates :name, presence: true
  validates :role, inclusion: { in: ROLES }

  def admin?
    self.role == 'admin'
  end

  def self.create_with_omniauth(info)
    create!(name: info['name'], nickname: info['nickname'], email: info['email'], image: info['image'])
  end
end
