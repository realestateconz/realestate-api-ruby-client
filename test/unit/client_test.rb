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
      assert_equal "c742042c6a82e517ddd637e1ee027e2d", api_sig
    end

    should "order the params correctly" do
      api_sig = @client.send(:calculate_api_sig, "suburbs/", :b => "Z", :a => [6, 3], "baz" => 45)

      assert_equal "1500f0d54ae8bef8c10a9d42e9a694fb", api_sig
    end

  end


  private

    def create_test_client
      Realestate::Client.new(:public_key => "123", :private_key => "456")
    end

end