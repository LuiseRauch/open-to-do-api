class List < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates :name, length: { minimum: 3 }, presence: true
  validates :user, presence: true
  # validates :permission, inclusion: { in: ['private', 'viewable', 'open'], allow_nil: true }
  validates :permissions, :inclusion => { :in => %w(private viewable open), :message => "%{value} is not a valid permission" }, :allow_nil => true
end
