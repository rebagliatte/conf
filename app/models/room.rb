class Room < ActiveRecord::Base

  attr_accessible :name

  has_many :talks

  validates :name, presence: true

end
