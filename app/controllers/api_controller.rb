class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def authorize_user
    list = List.find(params[:id])
    unless current_user == list.user
      render json: {error: "Not Authorized", status: 403}, status: 403
    end
  end

  def current_user
    name, password_digest = ActionController::HttpAuthentication::Basic::user_name_and_password(request)
    current_user = User.find_by( name: name )
  end

  def authenticated?
    authenticate_or_request_with_http_basic {|name, password_digest| User.where( name: name, password_digest: password_digest).present? }
  end
end
