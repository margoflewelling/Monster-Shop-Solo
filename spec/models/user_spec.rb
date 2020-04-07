require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it { should validate_uniqueness_of(:email_address).case_insensitive
                                                      .with_message("already has an account associated with it")}
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip_code }
    it { should validate_presence_of :email_address }
    it { should validate_presence_of :password }
    it { should validate_presence_of :confirm_password }
  end


end
