# WARNING: run seed user before animal, because animal must have user_id!!!
require 'json'
require 'open-uri'
require 'nokogiri'

fill_users = true
fill_animals = true

Booking.destroy_all


# generate Users
if fill_users
  puts "please wait we load some users for your zoo"
  User.destroy_all
  20.times do
    # generate email:
    user = User.new()
    user.email = Faker::Internet.free_email
    # generate password:
    user.password = "password"
    # generate name:
    user.name = Faker::Name.name
    # generate zoo(boolean):
    user.zoo = Faker::Boolean.boolean(true_ratio: 0.3)
    user.url_photo = ["https://static.vecteezy.com/system/resources/previews/000/652/388/non_2x/head-of-cute-little-boy-avatar-character-vector.jpg",
                       "https://static.vecteezy.com/system/resources/previews/000/649/839/non_2x/vector-head-of-cute-little-girl-avatar-character.jpg",
                       "https://image.freepik.com/vecteurs-libre/personnage-avatar-belle-tete-femme_24877-36794.jpg",
                       "https://image.freepik.com/vecteurs-libre/personnage-avatar-tete-jeune-homme_24877-36795.jpg",
                       "https://image.freepik.com/vecteurs-libre/jeune-homme-tete-personnage-avatar-barbe_24877-36786.jpg",
                       "https://static.vecteezy.com/system/resources/previews/000/652/509/non_2x/vector-head-of-cute-little-boy-avatar-character.jpg",
                       "https://static.vecteezy.com/system/resources/previews/000/649/904/non_2x/head-of-cute-little-girl-avatar-character-vector.jpg"].sample

    # generate address:
    if user.zoo
      user.address = ["6 Avenue de Royan, 17570 Les Mathes",
                      "ZooParc de Beauval, 41110 Saint Aignan sur Cher",
                      "3 Chemin du Transvaal, 33600 Pessac",
                      "Le Tertre Rouge, 72200 LA FLECHE",
                      "Le Foulon - D905, 21350 Arnay sous Vitteaux",
                      "Avenue de l’Océan - 40530 Labenne"].sample
    else
      user.address = Faker::Address.full_address
    end
    user.save!
  end
  puts "It's in DB, now you can use Users"
end

# generate Animals
if fill_animals
  list_of_zoo = User.where(zoo: true)
  count = 0
  puts "please wait we load some animals for your zoo"
  Animal.destroy_all
  # scrappe name:
  url = 'https://www.zoobeauval.com/les-animaux/'
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search('.container').each do |element|
    
    element.search('.card2').each do |description|
      animal = Animal.new()
      count += 1
      # verification
      puts count
      next if count <= 5
      # generate user_id:
      animal.user_id = list_of_zoo.sample.id
      # name
      animal.name = description.search('.card2__label--title').first.text.strip
      puts animal.name
      # description
      adresse = "https://www.zoobeauval.com" + description.search('.card2__label--actions a').first.attributes['href'].text.strip
      html_my_file = open(adresse).read
      html_my_doc = Nokogiri::HTML(html_my_file)
      animal.description = html_my_doc.search('.animal-text').first.text.strip
      puts animal.description

      classe = html_my_doc.search('.animal-facts li').first.text.strip
      puts classe
      regime = html_my_doc.search('.animal-facts li')[1].text.strip
      puts regime
      gestation = html_my_doc.search('.animal-facts li')[2].text.strip
      puts gestation
      portee = html_my_doc.search('.animal-facts li')[3].text.strip
      puts portee
      distribution = html_my_doc.search('.animal-facts li')[4].text.strip
      puts distribution
      habitat = html_my_doc.search('.animal-facts li')[5].text.strip
      puts habitat

      # # photo_url
      # animal.photo_url = description.search('img').attr('src').text.strip
      # puts animal.photo_url
      # hour_price
      animal.hour_price = Faker::Number.within(range: 50..500)
      puts animal.hour_price
      # address
      animal.address = User.find(animal.user_id).address
      puts animal.address
      # coordonnées:
      results = Geocoder.search(animal.address)
      puts results
      animal.latitude = results.first.coordinates[0]
      puts animal.latitude
      animal.longitude = results.first.coordinates[1]
      puts animal.longitude
      animal.save
    end
  end
end
puts "It's in DB! Now you can watch lots of animals!!!"
