require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(name: "User", password_digest: "password") }
  it { should have_many(:lists) }
  # Shoulda tests for name
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(1) }

  # Shoulda tests for password
  it { should validate_presence_of(:password) }
  it { should have_secure_password }
  it { should validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should respond to name" do
      expect(user).to respond_to(:name)
    end

    it "should respond to password_digest" do
      expect(user).to respond_to(:password_digest)
    end
  end

  describe "invalid user" do
    it "should be an invalid user due to blank name" do
      user_with_invalid_name = User.new(name: "", password: "password")
      expect(user_with_invalid_name).to_not be_valid
    end
  end
end
