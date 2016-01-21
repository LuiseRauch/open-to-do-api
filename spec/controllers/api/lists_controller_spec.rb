require 'rails_helper'

RSpec.describe Api::ListsController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_list) { create(:list, user: my_user) }

  context "unauthenticated users" do
    it "POST create returns http unauthenticated" do
      post :create, user_id: my_user.id, list: { name: my_list.name }
      expect(response).to have_http_status(401)
    end
    it "DELETE destroy returns http unauthenticated" do
      delete :destroy, user_id: my_user.id, id: my_list.id
      expect(response).to have_http_status(401)
    end
  end

  context "authenticated users" do
    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(my_user.name, my_user.password_digest)
    end

    describe "POST create" do
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "returns json content type" do
        post :create, user_id: my_user.id, list: { name: my_list.name }
        expect(response.content_type).to eq 'application/json'
      end
      it "creates a list with the correct attributes" do
        post :create, user_id: my_user.id, list: { name: my_list.name }
        hashed_json = JSON.parse(response.body)
        expect(my_list.name).to eq hashed_json["name"]
      end
    end

    describe "DELETE destroy" do
      it "deletes the list" do
        delete :destroy, user_id: my_user.id, id: my_list.id
        count = List.where({id: my_list.id}).size
        expect(count).to eq 0
      end
    end
  end
end
