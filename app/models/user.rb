class User < ActiveRecord::Base
  attr_accessible :name, :nickname, :email, :image

  has_many :identities

  def self.create_with_omniauth(info)
    create!(name: info['name'], nickname: info['nickname'], email: info['email'], image: info['image'])
  end
end
