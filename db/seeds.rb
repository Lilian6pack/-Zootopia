# WARNING: run seed user before animal, because animal must have user_id!!!
require 'json'
require 'open-uri'
require 'nokogiri'

fill_users = true
fill_animals = true


# generate Users
if fill_users
  puts "please wait we load some users for your zoo"
  User.destroy_all
  20.times do
    # generate email:
    user = User.new()
    user.email = Faker::Internet.free_email
    # generate password:
    user.password = Faker::Lorem.words(number: 10)
    # generate name:
    user.name = Faker::Name.name
    # generate zoo(boolean):
    user.zoo = Faker::Boolean.boolean(true_ratio: 0.2)
    puts user
    user.save!
  end
  puts "It's in DB, now you can use Users"
end

# generate Animals
if fill_animals
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
      animal.user_id = Faker::Number.within(range: User.first.id..User.last.id)
      # name
      animal.name = description.search('.card2__label--title').first.text.strip
      puts animal.name
      # user_id
      animal.user_id = Faker::Number.within(range: User.first.id..User.last.id)
      puts animal.user_id
      # description
      adresse = "https://www.zoobeauval.com" + description.search('.card2__label--actions a').first.attributes['href'].text.strip
      html_my_file = open(adresse).read
      html_my_doc = Nokogiri::HTML(html_my_file)
      animal.description = html_my_doc.search('.animal-text').first.text.strip
      puts animal.description
      # photo_url
      animal.photo_url = description.search('img').first.attributes['src']
      puts animal.photo_url
      # hour_price
      animal.hour_price = Faker::Number.within(range: 50..500)
      puts animal.hour_price
      animal.save
    end
  end
end
puts "It's in DB! Now you can watch lots of animals!!!"
