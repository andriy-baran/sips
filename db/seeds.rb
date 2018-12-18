# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = Account.create(email: "admin@example.com", password: 'test123', full_name: "Андрій", phone: "0507564911")
admin.add_role(:manager)

seller1 = Account.create(email: "seller1@example.com", password: 'test123', full_name: "Микола", phone: "0957804247")
seller2 = Account.create(email: "seller2@example.com", password: 'test123', full_name: "Василь", phone: "0687804541")
seller3 = Account.create(email: "seller3@example.com", password: 'test123', full_name: "Мирося", phone: "0507804984")

sellers = [seller1, seller2, seller3]
sellers.each{ |seller| seller.add_role(:seller) }

product1 = Product.create(title: 'фундук')
product2 = Product.create(title: 'кукурудза')
product3 = Product.create(title: 'кеш`ю')
product4 = Product.create(title: 'Мигдаль')
product5 = Product.create(title: 'Грецький')
product6 = Product.create(title: 'Лісовий')

weights = ['90 gram', '80 gram', '70 gram', '60 gram', '50 gram']
prices = ['90 UAH', '80 UAH', '70 UAH', '60 UAH', '50 UAH']

products = [product1, product2, product3, product4, product5, product6]
products.each do |product|
  Variant.create(product_id: product.id, weight: weights.sample, price: prices.sample)
end

place1 = Place.create(city: 'Львів', address: 'Площа Ринок 9')
place2 = Place.create(city: 'Львів', address: 'пр. Свободи 14')
place3 = Place.create(city: 'Івано-Франківськ', address: 'І.Франка 45')
place4 = Place.create(city: 'Тернопіль', address: 'Т.Шевченка 23')

pos1 = PointOfSale.create(title: 'ЛВ-1', place_id: place1.id)
pos2 = PointOfSale.create(title: 'ЛВ-2', place_id: place2.id)
pos3 = PointOfSale.create(title: 'ІФ-1', place_id: place3.id)
pos4 = PointOfSale.create(title: 'ТП-1', place_id: place4.id)

poses = [pos1, pos2, pos3, pos4]

# 1000.times do
#   product = products.sample
#   attrs = {
#     product_id: variant.product_id,
#     pos_id: @params[:pos_id],
#     account_id: account.id,
#     quantity: item.quantity,
#   }
#   Cashbox.create(attrs.merge(price: variant.price, kind: @params[:payment_type]))
#   Stock.create(attrs)
# end


