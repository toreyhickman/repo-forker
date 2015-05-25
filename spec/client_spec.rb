require 'repo_forker'

describe RepoForker::Client do
  describe ".new" do
    let(:client) { RepoForker::Client.new }

    it "is a kind of Ruby Net::HTTP object" do
      expect(client).to be_a_kind_of Net::HTTP
    end

    it "has the host of the GitHub api" do
      expect(client.address).to eq "api.github.com"
    end

    it "uses 443 as its port" do
      expect(client.port).to eq 443
    end

    it "uses ssl" do
      expect(client.use_ssl?).to be true
    end
  end
end
