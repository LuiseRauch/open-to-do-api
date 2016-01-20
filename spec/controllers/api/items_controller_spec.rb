# require 'rails_helper'
#
# RSpec.describe Api::ItemsController, type: :controller do
#   let(:my_user) { create(:user) }
#   let(:my_list) { create(:list) }
#   let(:my_item) { create(:item) }
#
#   context "unauthenticated users" do
#     it "POST create returns http unauthenticated" do
#       post :create, item: { list_id: my_list.id, name: my_item.name }
#       expect(response).to have_http_status(401)
#     end
#   end
#
#   context "authenticated users" do
#     before do
#       user = create(:user)
#       name = user.name
#       password_digest = user.password_digest
#
#       list = create(:list, user: user)
#       item = create(:item)
#
#       controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(name, password_digest)
#     end
#
#     describe "POST create" do
#       it "returns http success" do
#         expect(response).to have_http_status(:success)
#       end
#       it "returns json content type" do
#         new_item = build(:item)
#         post :create, item: { name: new_item.name, list_id: my_list.id }
#         expect(response.content_type).to eq 'application/json'
#       end
#       it "creates a user with the correct attributes" do
#         new_item = build(:item)
#         post :create, item: { name: new_item.name, list_id: my_list.id }
#         hashed_json = JSON.parse(response.body)
#         expect(list.items.last.name).to eq hashed_json["name"]
#       end
#     end
#   end
# end
