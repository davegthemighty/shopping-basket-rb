# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

baskets = Basket.create([{ total: 12.99 }, {}])
items = Item.create([{name: 'Beans', price: 5.99}, {name: 'Spam', price: 3.50}])

BasketLine.create(basket: baskets.first, item: items.first, quantity: 1)
BasketLine.create(basket: baskets.first, item: items.last, quantity: 2)
