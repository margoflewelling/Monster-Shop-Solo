class Merchant::ItemsController < Merchant::BaseController

  def index
    @merchant = Merchant.find(current_user.merchant_id)
    @items = @merchant.items
  end

  def update
    item = Item.find(params[:item_id])
    item.update(active?: false)
    redirect_to "/merchant/items"
    flash[:notice] = "#{item.name} is no longer for sale"
  end

end
