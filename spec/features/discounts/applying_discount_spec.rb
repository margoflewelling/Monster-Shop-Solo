require 'rails_helper'

RSpec.describe "applying discounts", type: :feature do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @bill = Merchant.create(name: "Bill's Dog Shop", address: '123 Dog Rd.', city: 'Denver', state: 'CO', zip: 80203)

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
      @shifter = @meg.items.create(name: "Shimano Shifters", description: "It'll always shift!", price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 2)
      @bone = @bill.items.create(name: "Bone", description: "Your dog will love it", price: 10, image: "https://assets.petco.com/petco/image/upload/f_auto,q_auto,t_ProductDetail-large/2730736-center-1", inventory: 20)

      @discount_1 = @meg.discounts.create(percentage: 20, min_quantity: 3)
      @discount_2 = @meg.discounts.create(percentage: 50, min_quantity: 5)

      visit '/'
      click_link 'Log in'
      fill_in :email_address, with: 'user@example.com'
      fill_in :password, with: '123'
      click_button 'Log in'
    end

    it "can see that a discount has applied to the cart and only applies to qualifying items" do
      click_on "All Items"
      click_on "Gatorskins"
      click_on "Add To Cart"
      click_on "Chain"
      click_on "Add To Cart"
      click_on "Cart"
      within "#cart-item-#{@tire.id}" do
        click_on "+"
        click_on "+"
        click_on "+"
      end
      page.refresh
      expect(page).to have_content("Total: $370")
      expect(page).to_not have_content("Total: $450")
    end

    it "can only use discount on items from that merchant with the discount" do
      click_on "All Items"
      click_on "Gatorskins"
      click_on "Add To Cart"
      click_on "Chain"
      click_on "Add To Cart"
      click_on "Bone"
      click_on "Add To Cart"
      click_on "Cart"

      within "#cart-item-#{@tire.id}" do
        click_on "+"
        click_on "+"
        click_on "+"
      end
      within "#cart-item-#{@bone.id}" do
        click_on "+"
        click_on "+"
        click_on "+"
      end
      page.refresh
      expect(page).to have_content("Total: $410")
    end

    it "can choose the better discount if two are available" do
      click_on "All Items"
      click_on "Gatorskins"
      click_on "Add To Cart"
      click_on "Chain"
      click_on "Add To Cart"
      click_on "Cart"
      within "#cart-item-#{@tire.id}" do
        click_on "+"
        click_on "+"
        click_on "+"
        click_on "+"
      end
      page.refresh
      expect(page).to have_content("Total: $300")
    end

    it "can apply the order to the cart" do
      click_on "All Items"
      click_on "Gatorskins"
      click_on "Add To Cart"
      click_on "Chain"
      click_on "Add To Cart"
      click_on "Cart"
      within "#cart-item-#{@tire.id}" do
        click_on "+"
        click_on "+"
        click_on "+"
        click_on "+"
      end
      click_on "Checkout"
      fill_in :name, with: "Margo"
      fill_in :address, with: "123 example"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80210"
      click_on "Create Order"
      order = Order.last
      click_on ("Order ##{order.id}")
      expect(order.grandtotal).to eq(300)
    end

  end
