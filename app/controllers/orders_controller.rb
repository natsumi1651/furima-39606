class OrdersController < ApplicationController
  before_action :move_to_index, only: :index
  before_action :no_valid_deal

  def index 
    @order_address = OrderAddress.new
  end

  def new
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :town, :block_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def move_to_index
    return if user_signed_in?

    redirect_to new_user_session_path
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.item_price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

   def no_valid_deal
    @item = Item.find(params[:item_id])
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    if @item.order.present? || current_user.id == @item.user_id
      redirect_to root_path
    end
   end

end
