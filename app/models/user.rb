class User < ApplicationRecord
  validates :email_address, uniqueness: { case_sensitive: false,
    message: "already has an account associated with it"}

  validates_presence_of :name,
                        :street_address,
                        :city,
                        :state,
                        :zip_code,
                        :email_address

  # add merchants controller(new create index show edit update destroy)
  # on create length validation rails for password
  enum role: {user: 0, merchant: 1, admin: 2}

  has_secure_password
end
