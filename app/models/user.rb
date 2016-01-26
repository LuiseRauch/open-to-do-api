class User < ActiveRecord::Base
  has_many :lists, dependent: :destroy
  has_many :items, through: :lists, dependent: :destroy

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password_digest, presence: true, length: { minimum: 6 }

end
