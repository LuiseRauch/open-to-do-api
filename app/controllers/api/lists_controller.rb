class Api::ListsController < ApiController
  before_action :authenticated?

  def create
    list = List.new(list_params)

    if list.save
      render json: list.to_json
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def list_params
    params.require(:list).permit(:user_id, :name)
  end

end
