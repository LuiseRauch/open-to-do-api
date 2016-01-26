require 'rails_helper'

RSpec.describe Api::ItemsController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_list) { create(:list, user: my_user) }
  let(:my_item) { create(:item) }

  context "unauthenticated users" do
    it "POST create returns http unauthenticated" do
      post :create, list_id: my_list.id, item: { name: my_item.name }
      expect(response).to have_http_status(401)
    end
    it "PUT update returns http unauthenticated" do
      put :update, list_id: my_list.id, id: my_item.id, item: {name: "Item Name"}
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
      before { post :create, list_id: my_list.id, item: { name: my_item.name } }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "returns json content type" do
        expect(response.content_type).to eq 'application/json'
      end
      it "creates an item with the correct attributes" do
        hashed_json = JSON.parse(response.body)
        expect(my_item.name).to eq hashed_json["name"]
      end
    end

    describe "PUT update" do
      before { put :update, list_id: my_list.id, id: my_item.id, item: {name: "Item Name"} }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "returns json content type" do
        expect(response.content_type).to eq 'application/json'
      end
      it "updates an item with the correct attributes" do
        updated_item = Item.find(my_item.id)
        expect(updated_item.to_json).to eq response.body
      end
    end
  end
end
