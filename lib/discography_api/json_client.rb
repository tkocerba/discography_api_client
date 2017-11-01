class JSONClient
  def initialize(root_url)
    @root_url = root_url
  end

  def get(path, params = {})
    response = connection.get path, params do |request|
      request.headers['Content-Type'] = "application/json"
    end

    body = response.body
    json = JSON.parse(body)
    json
  end

  def authenticate(auth_type, auth_content)
    @authentication = [auth_type, auth_content]
  end

  private

  def connection
    @connection ||= Faraday.new(:url => @root_url) do |faraday|
      faraday.request  :url_encoded
      faraday.adapter  Faraday.default_adapter
      faraday.authorization @authentication.first, @authentication.last if @authentication
    end
  end
end
