require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  let(:my_user) { create(:user) }

  context "unauthenticated users" do
    it "GET index returns http unauthenticated" do
      get :index
      expect(response).to have_http_status(401)
    end
    it "POST create returns http unauthenticated" do
      new_user = build(:user)
      post :create, user: { name: new_user.name, password_digest: new_user.password_digest }
      expect(response).to have_http_status(401)
    end
  end

  context "authenticated users" do
    before do
      user = create(:user)
      name = user.name
      password_digest = user.password_digest

      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(name, password_digest)
    end

    describe "GET index" do
      before { get :index }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "returns json content type" do
        expect(response.content_type).to eq 'application/json'
      end
    end

    describe "POST create" do
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "returns json content type" do
        new_user = build(:user)
        post :create, user: { name: new_user.name, password_digest: new_user.password_digest }
        expect(response.content_type).to eq 'application/json'
      end
      it "creates a user with the correct attributes" do
        new_user = build(:user)
        post :create, user: { name: new_user.name, password_digest: new_user.password_digest }
        hashed_json = JSON.parse(response.body)
        expect(new_user.name).to eq hashed_json["user"]["name"]
        expect(new_user.password_digest).to eq hashed_json["user"]["password_digest"]
      end
    end
  end
end
