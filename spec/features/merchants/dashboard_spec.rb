require 'rails_helper'

RSpec.describe 'As a merchant employee' do
  it 'I see the name and address of the merchant I work for on my dashboard' do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @merchant_employee = User.create({name: "Regina",
                         street_address: "6667 Evil Ln",
                         city: "Storybrooke",
                         state: "ME",
                         zip_code: "00435",
                         email_address: "evilqueen@example.com",
                         password: "henry2004",
                         password_confirmation: "henry2004",
                         role: 1,
                         merchant_id: @meg.id
                        })

    visit '/'

    click_on 'Log in'
    fill_in :email_address, with: 'evilqueen@example.com'
    fill_in :password, with: 'henry2004'
    click_button 'Log in'

    visit '/merchant'

    expect(page).to have_content(@meg.name)
    expect(page).to have_content(@meg.address)
    expect(page).to have_content(@meg.city)
    expect(page).to have_content(@meg.state)
    expect(page).to have_content(@meg.zip)
  end
end
