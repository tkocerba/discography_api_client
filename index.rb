require 'json'
require "awesome_print"
require "faraday"

conn = Faraday.new(:url => 'https://api.discogs.com') do |faraday|
  faraday.request  :url_encoded
  faraday.adapter  Faraday.default_adapter
  faraday.authorization :Discogs, "key=WOhynZfcesgDaTBDWDsn, secret=bsNSUjBpoQTnvwtEAMdCnXDSEGwrqDvk"
end

response = conn.get '/database/search', {q: 'Master of Puppets'} do |request|
  request.headers['Content-Type'] = "application/json"
end

json = JSON.parse(response.body)
results = json['results']
release = results.find { |e| e['type'] == 'release' && e['format'].include?('CD') && e['format'].include?('Album') }

url = release['resource_url']
response = conn.get(url)
album = JSON.parse(response.body)

puts "Tytuł: #{album['title']}"
puts "Artysta: #{album['artist']}"
puts "Gatunek #{album['genres'].join(', ')}"
puts "Styl #{album['styles'].join(', ')}"

puts "Lista utworów:"
album['tracklist'].each do |track|
  puts "#{track['position']}\t[#{track['duration']}]\t#{track['title']}"
end
