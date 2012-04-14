require File.join(File.dirname(__FILE__), '../test_helper.rb')

class ClientTest < ActiveSupport::TestCase

  context "creating a new client" do

    should "raise an exception unless public_key and private_key are specified" do

      assert_raises Realestate::CredentialsRequired do
        Realestate::Client.new
      end

      assert_nothing_raised do
        Realestate::Client.new(:public_key => "123", :private_key => "456")
      end

    end

  end

  context "generating api signatures" do
    setup do
      @client = create_test_client
    end

    should "generate correct signature" do
      api_sig = @client.send(:calculate_api_sig, "suburbs/", :a => 5)

      # here's a signature I prepared earlier...
      assert_equal "139a0697e7cb5ecd7f989157831f2af1", api_sig
    end

    should "order the params correctly" do
      api_sig = @client.send(:calculate_api_sig, "suburbs/", :b => "Z", :a => [6, 3], "baz" => 45)

      assert_equal "d5e86b009fde203a7e600e6f9f94c8aa", api_sig
    end

  end


  private

    def create_test_client
      Realestate::Client.new(:public_key => "123", :private_key => "456")
    end

end