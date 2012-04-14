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

end