# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Animal.destroy_all
User.destroy_all


user1 = User.create(name: 'John Do', email: 'user1@test.com', password: "azerty")
user2 = User.create(name: 'John Po', email: 'user2@test.com', password: "azerty")
animal1 = Animal.create(user_id: User.first.id, name: 'Pepito', description: 'A very sweet little lion.', photo_url: 'https://s3.eu-central-1.amazonaws.com/zooparc/assets/stars/lion_afrique_1_600.jpg', hour_price: 50)
animal2 = Animal.create(user_id: User.first.id, name: 'Guiselaine', description: 'A very sweet little girafe.', photo_url: 'https://s3.eu-central-1.amazonaws.com/zooparc/assets/stars/girafe_1_600.jpg', hour_price: 30)