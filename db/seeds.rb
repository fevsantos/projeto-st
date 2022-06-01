# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Cleaning database...'
User.destroy_all
Questionnaire.destroy_all
Question.destroy_all


puts 'Creating Quiz e Questions...'
users = User.create!([])
caloi.photos.attached(io: file, filename: '1xg.jpg', content_type: 'image/jpg')
#Product.create!(price_cents: 25000, sku: 'Monark', category: kids 'https://imgs.casasbahia.com.br/1710359/1xg.jpg')
#Product.create!(price_cents: 100000, sku: 'Trek', category: eletric 'https://cdn.shopify.com/s/files/1/0899/5402/products/eb-02_perfil_1080x.png')
puts 'Finished!'
