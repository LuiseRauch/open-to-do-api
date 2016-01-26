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
    it "DELETE destroy returns http unauthenticated" do
      delete :destroy, id: my_user.id
      expect(response).to have_http_status(401)
    end
  end

  context "authenticated users" do
    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(my_user.name, my_user.password_digest)
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
      before { post :create, user: { name: my_user.name, password_digest: my_user.password_digest } }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "returns json content type" do
        expect(response.content_type).to eq 'application/json'
      end
      it "creates a user with the correct attributes" do
        hashed_json = JSON.parse(response.body)
        expect(my_user.name).to eq hashed_json["user"]["name"]
        expect(my_user.password_digest).to eq hashed_json["user"]["password_digest"]
      end
    end

    describe "DELETE destroy" do
      it "deletes the user" do
        delete :destroy, id: my_user.id
        count = User.where({id: my_user.id}).size
        expect(count).to eq 0
      end
    end
  end
end
