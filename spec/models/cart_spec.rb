require 'rails_helper'

describe Cart, type: :model do
  describe "instance_methods" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @user = User.create({name: "Regina",
                           street_address: "6667 Evil Ln",
                           city: "Storybrooke",
                           state: "ME",
                           zip_code: "00435",
                           email_address: "user@example.com",
                           password: "123",
                           password_confirmation: "123",
                           role: 0,
                           merchant_id: @meg.id
                          })

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @shifter = @meg.items.create(name: "Shimano Shifters", description: "It'll always shift!", active?: false, price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 2)
      @discount_1 = @meg.discounts.create(percentage: 20, min_quantity: 3)
      @discount_2 = @meg.discounts.create(percentage: 30, min_quantity: 5)
   end


  it "best_discount" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    cart1 = Cart.new({"#{@tire.id}" => 4, "#{@chain.id}" => 1})
    expect(cart1.best_discount(@tire)).to eq(0.2)
    cart2 = Cart.new({"#{@tire.id}" => 5, "#{@chain.id}" => 1})
    expect(cart2.best_discount(@tire)).to eq(0.3)
  end

end
end
