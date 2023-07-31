class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to '/'
    else
     render :new
    end
    
  end

  private 

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :shipmentfee_id, :prefecture_id, :waitingday_id, :item_price, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

end