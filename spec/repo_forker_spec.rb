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
    it "returns a Client object" do
      expect(RepoForker.client).to be_an_instance_of RepoForker::Client
    end
  end

  describe ".fork" do
    let(:repo_1) { "some_repo" }
    let(:repo_2) { "some_other_repo" }
    let(:list)   { [repo_1, repo_2] }

    let(:mock_api_key)     { "123456" }
    let(:mock_source)      { "good_coder" }
    let(:mock_destination) { "helper" }

    before(:each) do
      RepoForker.configure do |config|
        config.api_key     = mock_api_key
        config.source      = mock_source
        config.destination = mock_destination
      end
    end

    after(:each) do
      RepoForker.reset
    end

    describe "for each repo in list" do
      it "builds a URI object" do
        allow(RepoForker::URI_Builder).to receive(:build)

        list.each do |repo_name|
          expect(RepoForker::URI_Builder).to receive(:build).with(repo_name)
        end

        RepoForker.fork list
      end
    end
  end
end
