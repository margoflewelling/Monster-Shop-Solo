class Merchant::DiscountsController< Merchant::BaseController

  def index
    @merchant = current_user
  end

  def create
    @merchant = current_user
    discount = @merchant.merchant.discounts.create(discount_params)
    if discount.save
      flash[:notice] = "Your discount has been created"
    else
      flash[:error] = discount.errors.full_messages.to_sentence
    end
    redirect_to "/merchant/discounts"
  end

  def destroy
    discount = Discount.find(params[:id])
    discount.destroy
    redirect_to "/merchant/discounts"
  end

  def edit
    @merchant = current_user
    @discount_to_edit = Discount.find(params[:id])
    render :index
  end

  def update
    @discount = Discount.find(params[:id])
      if @discount.update(discount_params) && @discount.save
        flash[:notice] = "Your discount has been updated"
      else
        flash[:error] = @discount.errors.full_messages.to_sentence
      end
    redirect_to "/merchant/discounts"
  end


private

  def discount_params
    params.permit(:percentage, :min_quantity)
  end

end
