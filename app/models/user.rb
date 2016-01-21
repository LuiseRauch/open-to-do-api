class User < ActiveRecord::Base
  has_many :lists
  has_many :items, through: :lists


  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password_digest, presence: true, length: { minimum: 6 }

end
