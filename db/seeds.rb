# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# require 'open-uri'



  # response = RestClient.get('http://www.montana-cans.com/products/Cans/Montana_BLACK/Montana_BLACK_400ml/20')
  response = open('bin/montana_gold.html')
  # puts response

  # Nokogiri parses through html and returns something readable
  document = Nokogiri::HTML(response)

  # get montana black colors and skus
  paints = Hash.new


  document.css('.color-item.bright').each do |item|
    paint_name = item.css('span').text.strip
    filtered = /\w+/.match(item.parent.styles['background']).to_s
    # components = filtered.scan(/.{2}/)
    # components = components.map{|component| component.match(/[0-9A-Fa-f]{2}/)}
    # components = components.map { |component| component.hex}
    paints[paint_name]=filtered
    Paint.create(name:paint_name,component1:paints[paint_name],brand_id:1)
  end
  puts paints