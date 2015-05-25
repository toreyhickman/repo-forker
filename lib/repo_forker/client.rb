module RepoForker
  class Client < Net::HTTP
    def self.create
      client = new(uri.host, uri.port)
      client.use_ssl = true
      client
    end

    private
    def self.uri
      @uri ||= URI(RepoForker.endpoint)
    end
  end
end
