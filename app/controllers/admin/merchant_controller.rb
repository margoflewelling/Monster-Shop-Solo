class Admin::MerchantController < Admin::BaseController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def disable
    @merchants = Merchant.all
    @merchants.each do |merchant|
      merchant.users.each do |user|
        if user.merchant_id == merchant.id
          flash[:notice] = "#{merchant.name}'s account is now disabled"
          merchant.update(active?: false)
          merchant.deactivate_items
        end
      end
    end
    redirect_to '/admin/merchants'
  end

  def enable
    @merchants = Merchant.all
    @merchants.each do |merchant|
      merchant.users.each do |user|
        if user.merchant_id == merchant.id
          flash[:notice] = "#{merchant.name}'s account is now enabled"
          merchant.update(active?: true)
          merchant.activate_items
        end
      end
    end
    redirect_to '/admin/merchants'
  end
end
