require 'rails_helper'

RSpec.describe 'As a visitor' do
  it 'can not access merchant, admin, or profile' do


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/merchant"
    expect(page).to have_content("The page you were looking for doesn't exist.")

    visit "/admin"
    expect(page).to have_content("The page you were looking for doesn't exist.")

    visit "/profile"
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end
