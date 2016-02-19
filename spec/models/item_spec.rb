require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to(:list) }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(3) }

  describe "attributes" do
    it "should respond to name" do
      user = User.create!(name: "User", password_digest: "password")
      list = user.lists.create!(name: "List")
      item = Item.create!(name: "Item", completed: "false", list: list)
      expect(item).to respond_to(:name)
    end
  end
end
