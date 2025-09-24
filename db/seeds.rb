# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = Account.create!(email: "admin@example.com", password: 'test123', full_name: "Андрій", phone: "0507564911", role: 'manager')

product1 = Product.create(title: 'фундук')
product2 = Product.create(title: 'кукурудза')
product3 = Product.create(title: 'кеш`ю')
product4 = Product.create(title: 'Мигдаль')
product5 = Product.create(title: 'Грецький')
product6 = Product.create(title: 'Лісовий')

weights = ['90 g', '80 g', '70 g', '60 g', '50 g']
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

seller1 = Account.create!(email: "seller1@example.com", password: 'test123', full_name: "Микола", phone: "0957804247", pos_id: pos1.id, role: 'seller')
seller2 = Account.create!(email: "seller2@example.com", password: 'test123', full_name: "Василь", phone: "0687804541", pos_id: pos2.id, role: 'seller')
seller3 = Account.create!(email: "seller3@example.com", password: 'test123', full_name: "Мирося", phone: "0507804984", pos_id: pos3.id, role: 'seller')

sellers = [seller1, seller2, seller3]

31.times do |d|
  time =  Time.zone.now - d.days
  Timecop.travel(time) do
    (80..150).to_a.sample.times do |n|
      product = products.sample
      seller = sellers.sample
      attrs = {
        product_id: product.id,
        pos_id: seller.pos_id,
        account_id: seller.id,
        quantity: rand(1..3),
      }
      Cashbox.create(attrs.merge(price_uah: product.variant.price.to_f, kind: %w(cash card).sample))
      Stock.create(attrs.merge(weight_kilogram: product.variant.weight.convert_to('kilogram'), kind: 'sell'))
    end
    products.each do |product|
      sellers.each do |seller|
        res = Stock.sold.on_day.select('sum(weight_kilogram * quantity) as sold_weight').where(product_id: product.id).group('stocks.id').first
        sold = res.sold_weight
        total = sold + (sold * rand(0.0..0.4).round(2))
        attrs = {
          product_id: product.id,
          pos_id: seller.pos_id,
          account_id: seller.id,
          quantity: rand(1..5),
          weight_kilogram: total,
          kind: 'checkout'
        }
        Stock.create(attrs)
        Stock.create(attrs.merge(weight_kilogram: total + rand(1.1..5.5).round(2),kind: 'checkin')) unless (rand(1..4) / 4).zero?
      end
    end
  end
end



