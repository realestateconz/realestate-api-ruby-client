require File.join(File.dirname(__FILE__), '../test_helper.rb')

# this file tests the live client
class LiveClientTest < ActiveSupport::TestCase

  context "authentication" do
    setup do
      @client = create_test_client
    end

    should "raise AuthenticationError if we don't specify an api key" do
      @client.public_key = ""

      assert_raises Realestate::AuthenticationError, "Api key was not provided" do
        @client.suburbs
      end
    end

    should "raise AuthenticationError if the API is made up" do
      @client.public_key = "123"

      assert_raises Realestate::AuthenticationError, "Api key \"123\" not found" do
        @client.suburbs
      end
    end

  end

  context "listing suburbs" do
    setup do
      @client = create_test_client
    end

    should "be able to list re.co.nz suburbs" do
      result = @client.suburbs

      raise result.inspect
    end
  end

  private

    def create_test_client
      Realestate::Client.new(:public_key => TEST_CREDENTIALS[:public_key], :private_key => TEST_CREDENTIALS[:private_key])
    end

end