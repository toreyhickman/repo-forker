require 'repo_forker'

describe RepoForker do
  it "has a version" do
    expect(RepoForker::VERSION).to_not be_nil
  end

  describe "default values" do
    RepoForker::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "has a default #{key}" do
        constant_name = "DEFAULT_#{key.upcase}"
        expected_default_value = RepoForker::Configuration.const_get(constant_name)
        expect(RepoForker.send(key)).to eq expected_default_value
      end
    end
  end

  describe ".configure" do
    after(:each) do
      RepoForker.reset
    end

    RepoForker::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "sets the #{key}" do
        RepoForker.configure do |config|
          config.send("#{key}=", key)
        end

        expect(RepoForker.send(key)).to eq key
      end
    end
  end

  describe ".client" do
    it "returns a Ruby Net::HTTP object" do
      expect(RepoForker.client).to be_an_instance_of Net::HTTP
    end

    it "has the host of the GitHub api" do
      expect(RepoForker.client.address).to eq "api.github.com"
    end

    it "uses 443 as its port" do
      expect(RepoForker.client.port).to eq 443
    end
  end
end
