class Merchant::ItemsController < Merchant::BaseController

  def index
    @merchant = Merchant.find(current_user.merchant_id)
    @items = @merchant.items
  end

  def update
    item = Item.find(params[:item_id])
    if params[:activate_or_deactivate] == "deactivate"
      item.update(active?: false)
      flash[:notice] = "#{item.name} is no longer for sale"
    elsif params[:activate_or_deactivate] == "activate"
      item.update(active?: true)
      flash[:notice] = "#{item.name} is now available for sale"
    end
    redirect_to "/merchant/items"
  end

end
