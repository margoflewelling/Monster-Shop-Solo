class Admin::MerchantController < Admin::BaseController

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end
  
end
