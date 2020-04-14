class OrdersController <ApplicationController

  def new
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    order = Order.create(order_params)
    order.status = 'Pending'
    order.user_id = current_user.id
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      session.delete(:cart)
      flash[:notice] = "Thank you for placing your order!"
      redirect_to "/user/profile/orders"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end

  def update
    order = Order.find(params[:id])
    order.update(status: "Shipped")
    redirect_to "/admin"
  end

  def destroy
    order = Order.find(params[:id])
    flash[:notice] = "Order ##{order.id} has been cancelled"
    order.update(status: "Cancelled")
    redirect_to "/user/profile"
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
