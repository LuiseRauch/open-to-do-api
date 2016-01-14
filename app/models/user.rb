class User < ActiveRecord::Base
  has_many :lists
  has_many :items, through: :lists


  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true

  has_secure_password
end
