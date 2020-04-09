require 'rails_helper'

RSpec.describe 'As a visitor' do
    before(:each) do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 2)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      visit "/items/#{@paper.id}"
      click_on "Add To Cart"
      visit "/items/#{@tire.id}"
      click_on "Add To Cart"
      visit "/items/#{@pencil.id}"
      click_on "Add To Cart"
      @items_in_cart = [@paper,@tire,@pencil]
    end
    it 'I see a button to increment the count of items I want to purchase in my cart' do
      visit '/cart'

      within "#cart-item-#{@tire.id}" do
        click_button "+"
        expect(page).to have_content(2)

        click_button "+"
        expect(page).to have_content(2)
      end

      expect(page).to have_content("Do not have enough of this item in stock, please choose another.")

    end

    it 'I see a button '
end


# As a visitor
# When I have items in my cart
# And I visit my cart
# Next to each item in my cart
# I see a button or link to increment the count of items I want
# to purchase
# I cannot increment the count beyond the item's inventory size