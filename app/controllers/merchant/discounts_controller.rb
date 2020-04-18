class Merchant::DiscountsController< Merchant::BaseController

  def index
    @merchant = current_user
  end

  def create
    @merchant = current_user
    @merchant.merchant.discounts.create(discount_params)
    redirect_to "/merchant/discounts"
  end

  def destroy
    discount = Discount.find(params[:id])
    discount.destroy
    redirect_to "/merchant/discounts"
  end


private

  def discount_params
    params.permit(:percentage, :min_quantity)
  end

end
