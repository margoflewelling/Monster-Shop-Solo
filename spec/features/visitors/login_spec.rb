require 'rails_helper'

RSpec.describe 'as a visitor', type: :feature do
  it "can login as a regular user" do
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
    expect(page).to have_content("Welcome #{user.name}! You are now logged in!")
    expect(current_path).to eq('/user/profile')
  end

  it "can login as a merchant user" do
    merchant = User.create({name: "Fred", street_address: "22 dog st", city: "Fort Collins",
                         state: "CO", zip_code: "80375", email_address: "fred@example.com",
                         password: "password1", password_confirmation: "password1", role: 1
                        })
    visit '/login'
    fill_in :email_address, with: "fred@example.com"
    fill_in :password, with: "password1"
    within ("#login-form") do
      click_on "Log in"
    end
    expect(page).to have_content("Welcome #{merchant.name}! You are now logged in!")
    expect(current_path).to eq('/merchant')
  end

  it "can login as an admin user" do
    admin = User.create({name: "Jill", street_address: "22 dog st", city: "Fort Collins",
                         state: "CO", zip_code: "80375", email_address: "jill@example.com",
                         password: "password1", password_confirmation: "password1", role: 2
                        })
    visit '/login'
    fill_in :email_address, with: "jill@example.com"
    fill_in :password, with: "password1"
    within ("#login-form") do
      click_on "Log in"
    end
    expect(page).to have_content("Welcome #{admin.name}! You are now logged in!")
    expect(current_path).to eq('/admin')
  end


end



# User Story 13, User can Login
#
# As a visitor
# When I visit the login path
# I see a field to enter my email address and password
# When I submit valid information
# If I am a regular user, I am redirected to my profile page
# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to my admin dashboard page
# And I see a flash message that I am logged in
