class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
    redirect_to '/'
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :shipmentfee_id, :prefecture_id, :waitingday_id, :item_price,  :image).merge(user_id: current_user.id)
  end
end
