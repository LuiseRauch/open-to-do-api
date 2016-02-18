class Api::ItemsController < ApiController
  before_action :authenticated?
  before_action :authorize_user#, except: [:index]

  def index
    items = Item.all
    render json: items, each_serializer: ItemSerializer
  end


  def create
    item = Item.new(item_params)
    # assign this item to the list in the url based on params[:list_id]
    item.list_id = params[:list_id]

    if item.save
      render json: item.to_json
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    item = Item.find(params[:id])

    if item.update(item_params)
      render json: item.to_json
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :completed)
  end
  # def authorize_user
  #   item = Item.find(params[:id])
  #   unless current_user == item.user
  #     render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end
end
