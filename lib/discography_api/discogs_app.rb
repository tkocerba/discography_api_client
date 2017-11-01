class DiscogsApp
  def initialize(phrase)
    @phrase = phrase
  end

  def run
    client = DiscogsClient.new
    release = client.search @phrase
    url = release['resource_url']
    album = client.find_album(url)
    AlbumFormatter.new(album).print_album
  end
end
