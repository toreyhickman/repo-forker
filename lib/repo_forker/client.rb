module RepoForker
  class Client < Net::HTTP
    def self.new(host = uri.host, port = uri.port)
      super(host, port)
    end

    def initialize(host, port)
      super
      self.use_ssl = true
    end

    private
    def self.uri
      @uri ||= URI(RepoForker.endpoint)
    end
  end
end
