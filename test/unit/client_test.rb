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
      assert_equal "963c93415aaba0b605d93daea7faa642", api_sig
    end

    should "order the params correctly" do
      api_sig = @client.send(:calculate_api_sig, "suburbs/", :b => "Z", :a => [6, 3], "baz" => 45)

      assert_equal "d1902758cc1feeea3c0a9b6c96d3f7d0", api_sig
    end

  end

  context "category methods" do
    setup do
      @client = create_test_client
    end

    should "work with mock data" do
      flunk
    end
  end

  context "requesting listings" do
    setup do
      @client = create_test_client
    end

    should "return all pages with pagination" do
      flunk
    end
  end


  private

    def create_test_client
      Realestate::Client.new(:public_key => "123", :private_key => "456")
    end

end