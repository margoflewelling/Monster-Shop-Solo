require 'rails_helper'

RSpec.describe 'As an admin' do
  describe 'When I visit the admin merchant page' do
    it 'I see a disable button next to all active merchants' do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      brian = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203, active?:false)

      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      pull_toy = meg.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      dog_bone = meg.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

      visit '/admin/merchants'

      within "#cart-item-#{tire.id}" do
        expect(tire.active?).to be_truthy
      end

      within "#cart-item-#{pull_toy.id}" do
        expect(pull_toy.active?).to be_truthy
      end

      within "#cart-item-#{dog_bone.id}" do
        expect(dog_bone.active?).to be_falsey
      end

      within "#merch-shop-#{brian.id}" do
        expect(page).to have_no_content('disable')
      end

      within "#merch-shop-#{meg.id}" do
        click_button 'disable'
      end

      expect(current_path).to eq('/admin/merchants')
      expect(page).to have_content("#{meg.name}'s account is now disabled")

      within "#cart-item-#{tire.id}" do
        expect(tire.active?).to be_falsey
      end

      within "#cart-item-#{pull_toy.id}" do
        expect(pull_toy.active?).to be_falsey
      end

      within "#cart-item-#{dog_bone.id}" do
        expect(dog_bone.active?).to be_falsey
      end

      within "#merch-shop-#{meg.id}" do
        expect(page).to have_no_content('disable')
      end
    end
  end
end

# As an admin
# When I visit the admin's merchant index page ('/admin/merchants')
# I see a "disable" button next to any merchants who are not yet disabled
# When I click on the "disable" button
# I am returned to the admin's merchant index page where I see that the merchant's account is now disabled
# And I see a flash message that the merchant's account is now disabled