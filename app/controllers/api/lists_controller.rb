class Api::ListsController < ApiController
  before_action :authenticated?
  before_action :authorize_user#, except: [:index]

  def index
    lists = List.all
    render json: lists, each_serializer: ListSerializer
  end

  def create
    list = List.new(list_params)
    # assign this list to the user in the url based on params[:user_id]
    list.user_id = params[:user_id]

    if list.save
      render json: list.to_json
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      list = List.find(params[:id])
      list.destroy
      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    end
  end

  def update
    list = List.find(params[:id])

    if list.update(list_params)
      render json: list.to_json
    else
      render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def list_params
    params.require(:list).permit(:name, :permissions)
  end

  # def authorize_user
  #   list = List.find(params[:id])
  #   unless current_user == list.user
  #     render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end
end
