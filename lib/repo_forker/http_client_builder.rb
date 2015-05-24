module RepoForker
  module HTTPClientBuilder
    def self.build
      Net::HTTP.new(uri.host, uri.port)
    end

    private
    def self.uri
      @uri ||= URI(RepoForker.endpoint)
    end
  end
end
