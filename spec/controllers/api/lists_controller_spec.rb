# require 'rails_helper'
#
# RSpec.describe Api::ListsController, type: :controller do
#   let(:my_user) { create(:user) }
#   let(:my_list) { create(:list)}
#
#   context "unauthenticated users" do
#     it "POST create returns http unauthenticated" do
#       post :create, list: { user_id: my_user.id, name: my_list.name }
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
#
#       controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(name, password_digest)
#     end
#
#     describe "POST create" do
#       it "returns http success" do
#         expect(response).to have_http_status(:success)
#       end
#       it "returns json content type" do
#         new_list = build(:list)
#         post :create, list: { name: new_list.name, user_id: my_user.id }
#         expect(response.content_type).to eq 'application/json'
#       end
#       it "creates a user with the correct attributes" do
#         new_list = build(:list)
#         post :create, list: { name: new_list.name, user_id: my_user.id }
#         hashed_json = JSON.parse(response.body)
#         expect(user.lists.first.name).to eq hashed_json["name"]
#       end
#     end
#   end
# end
