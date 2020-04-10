class Merchant::DashboardController < Merchant::BaseController
  def index
    @merchant = Merchant.find(current_user.merchant_id)
    require "pry"; binding.pry
    Order.joins(:item).where(item: {merchant: @merchant})
  end
end
