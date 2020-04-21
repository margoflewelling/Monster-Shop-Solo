# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.destroy_all
Item.destroy_all
User.destroy_all
Order.destroy_all
ItemOrder.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
tube = bike_shop.items.create(name: "Tube", description: "Always carry a spare!", price: 5, image: "https://www.rei.com/media/ee25324f-ef69-4814-b94c-7967ad5eeeee?size=784x588", inventory: 40)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "https://images-na.ssl-images-amazon.com/images/I/71L30-Xfs9L._AC_SX425_.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)

#users
bob = User.create({name: "Bob",
                   street_address: "22 dog st",
                   city: "Fort Collins",
                   state: "CO",
                   zip_code: "80375",
                   email_address: "user@example.com",
                   password: "password_regular",
                   password_confirmation: "password_regular",
                   role: 0
                    })
regina = User.create({name: "Regina",
                       street_address: "6667 Evil Ln",
                       city: "Storybrooke",
                       state: "ME",
                       zip_code: "00435",
                       email_address: "merchant1@example.com",
                       password: "password_merchant",
                       password_confirmation: "password_merchant",
                       role: 1,
                       merchant_id: bike_shop.id
                      })

regina = User.create({name: "Elmo",
                       street_address: "123 Sesame St",
                       city: "New York City",
                       state: "NY",
                       zip_code: "10001",
                       email_address: "merchant2@example.com",
                       password: "password_merchant",
                       password_confirmation: "password_merchant",
                       role: 1,
                       merchant_id: dog_shop.id
                      })

bert = User.create({name: "Bert",
                      street_address: "123 Sesame St.",
                      city: "New York City",
                      state: "NY",
                      zip_code: "10001",
                      email_address: "admin@example.com",
                      password: "password_admin",
                      password_confirmation: "password_admin",
                      role: 2
                     })

#orders
