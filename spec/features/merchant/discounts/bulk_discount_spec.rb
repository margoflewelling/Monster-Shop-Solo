require 'rails_helper'

RSpec.describe "Merchants can add bulk discount rate", type: :feature do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @merchant = User.create({name: "Regina",
                           street_address: "6667 Evil Ln",
                           city: "Storybrooke",
                           state: "ME",
                           zip_code: "00435",
                           email_address: "merchant@example.com",
                           password: "123",
                           password_confirmation: "123",
                           role: 1,
                           merchant_id: @meg.id
                          })

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @shifter = @meg.items.create(name: "Shimano Shifters", description: "It'll always shift!", active?: false, price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 2)
      visit '/'

      click_link 'Log in'

      fill_in :email_address, with: 'merchant@example.com'
      fill_in :password, with: '123'
      click_button 'Log in'
    end

    it "merchant can go to a bulk discounts page from their dashboard" do
      expect(page).to have_link("Bulk Discounts")
      click_on("Bulk Discounts")
      expect(current_path).to eq("/merchant/discounts")
    end

    it "can add bulk discounts from index page" do
    end

  end

    # Merchants need full CRUD functionality on bulk discounts, and will be accessed a link on the merchant's dashboard.
    # You will implement a percentage based discount:
    # 5% discount on 20 or more items
    # A merchant can have multiple bulk discounts in the system.
    # When a user adds enough value or quantity of a single item to their cart, the bulk discount will automatically show up on the cart page.
    # A bulk discount from one merchant will only affect items from that merchant in the cart.
    # A bulk discount will only apply to items which exceed the minimum quantity specified in the bulk discount. (eg, a 5% off 5 items or more does not activate if a user is buying 1 quantity of 5 different items; if they raise the quantity of one item to 5, then the bulk discount is only applied to that one item, not all of the others as well)
    # When there is a conflict between two discounts, the greater of the two will be applied.
