class AlbumFormatter
  def initialize(album)
    @album = album
  end

  def print_album
    puts "Tytuł: #{@album['title']}"
    puts "Artysta: #{@album['artists'].first['name']}"
    puts "Gatunek #{@album['genres'].join(', ')}"
    puts "Styl #{@album['styles'].join(', ')}"

    puts "Lista utworów:"
    @album['tracklist'].each do |track|
      puts "#{track['position']}\t[#{track['duration']}]\t#{track['title']}"
    end
  end
end
