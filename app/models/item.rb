class Item < ActiveRecord::Base
  belongs_to :list, dependent: :destroy

  validates :name, length: { minimum: 3 }, presence: true
  validates :completed, :inclusion => {:in => [true, false], :message => "%{value} is not valid"}, :allow_nil => true
end
