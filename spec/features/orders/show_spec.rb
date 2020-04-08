RSpec.describe("Orders Show Page") do

  describe "User Profile displays Orders link" do
    before(:each) do
      user = User.create({name: "Bob", street_address: "22 dog st", city: "Fort Collins",
                           state: "CO", zip_code: "80375", email_address: "bob@example.com",
                           password: "password1", password_confirmation: "password1", role: 0
                          })
      visit '/login'
      fill_in :email_address, with: "bob@example.com"
      fill_in :password, with: "password1"
      within ("#login-form") do
        click_on "Log in"
      end
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    it "can see link if there are orders" do
      Order.create({name: "Bob", address: "22 dog st", city: "Fort Collins",
                           state: "CO", zip: "80375"})
      visit '/user/profile'
      click_on "My Orders"
      expect(current_path).to eq("/user/profile/orders")
    end
  end
end






# As a registered user
# When I visit my Profile page
# And I have orders placed in the system
# Then I see a link on my profile page called "My Orders"
# When I click this link my URI path is "/profile/orders"
