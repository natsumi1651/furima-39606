class OrdersController < ApplicationController
  before_action :move_to_index, only: [:index]

  def index
   @item = Item.find(params[:item_id])
   if current_user.id != @item.user_id
    @order_address = OrderAddress.new
   else
    redirect_to items_path
   end
  end

  def new  
    @order_address = OrderAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  
  def order_params
    params.require(:order_address).permit(:item_id, :post_code, :prefecture_id, :town, :block_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def move_to_index
    return if user_signed_in?
    redirect_to new_user_session_path
  end
  

end
