class BookInventoryItemsController < ApplicationController
  def create
    @item = BookInventoryItem.new(item_params)

    if @item.save
      redirect_to book_inventory_items_path, notice: "Saved book!"
    else
      flash[:error] = "Couldn't save! #{@item.errors.full_messages}"
      render :index
    end
  end

  def index
    @items = BookInventoryItem.order(created_at: :desc)
    @item = BookInventoryItem.new
  end

  def edit
    @item = BookInventoryItem.find(params[:id])
  end

  def update
    @item = BookInventoryItem.find(params[:id])

    if @item.update(item_params)
      redirect_to book_inventory_items_path, notice: "Updated book!"
    else
      flash[:error] = "Couldn't update! #{@item.errors.full_messages}"
      render :edit
    end
  end

  def destroy
    item = BookInventoryItem.find(params[:id])
    item.destroy
    redirect_to book_inventory_items_path, notice: "Deleted book!"
  end

  private

  def item_params
    allowed_params = params.require(:book_inventory_item).permit(:name, :author, categories: ['0', '1'])
    allowed_params[:categories] =  allowed_params[:categories].map { |_k,v| v.presence }.compact
    allowed_params
  end
end
