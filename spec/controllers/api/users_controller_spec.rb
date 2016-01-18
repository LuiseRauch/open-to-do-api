# require 'rails_helper'
#
# RSpec.describe Api::UsersController, type: :controller do
#   let(:user) { User.create!(name: "User", password_digest: "password") }
#
#   context "unauthenticated users" do
#     it "GET index returns http unauthenticated" do
#       get :index
#       expect(response).to have_http_status(401)
#     end
#   end
#
#   context "authenticated users"
#     before do
#       controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.auth_token)
#     end
#
#     it "GET index" do
#       before { get :index }
#
#       it "returns http success" do
#         expect(response).to have_http_status(:success)
#       end
#       it "returns json content type" do
#         expect(response.content_type).to eq 'application/json'
#       end
#     end
#
# end
