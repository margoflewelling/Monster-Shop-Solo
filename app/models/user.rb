class User < ApplicationRecord
  validates :email_address, uniqueness: { case_sensitive: false,
    message: "already has an account associated with it"}

  validates_presence_of :name,
                        :street_address,
                        :city,
                        :state,
                        :zip_code,
                        :email_address,
                        :password

end
