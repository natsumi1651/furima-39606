class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :no_edit_authority, only: :edit

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
   
  end

  def edit
  
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :shipmentfee_id, :prefecture_id, :waitingday_id,
                                 :item_price, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    return if user_signed_in?
    redirect_to new_user_session_path
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def no_edit_authority
    return if @item.user == current_user

    redirect_to root_path
  end
end
