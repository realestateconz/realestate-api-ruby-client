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

  context "category methods" do
    setup do
      @client = create_test_client
    end

    should "be able to list re.co.nz suburbs" do
      result = @client.suburbs

      assert fiji = result.detect { |s| s["id"] == 3312 }

      assert_equal "Fiji", fiji["name"]
      assert_equal 54,     fiji["region_id"]
    end

    should "be able to list re.co.nz districts" do
      result = @client.districts

      assert fiji = result.detect { |s| s["id"] == 1 }

      assert_equal "Fiji", fiji["name"]
      assert_equal 54,     fiji["region_id"]
    end

    should "be able to list re.co.nz regions" do
      result = @client.regions

      assert northland = result.detect { |s| s["id"] == 34 }

      assert_equal "Northland", northland["name"]
    end

    should "be able to list re.co.nz listing types" do
      result = @client.listing_types

      assert residential = result.detect { |s| s["id"] == 1 }

      assert_equal "Residential", residential["name"]
      assert residential["sub_types"].map { |st| st["name"] }.include?("Apartment")
    end

    should "be able to list re.co.nz pricing methods" do
      result = @client.pricing_methods

      assert fixed = result.detect { |r| r["id"] == 1 }
      assert_equal "Fixed Price", fixed["name"]
    end

  end

  private

    def create_test_client
      Realestate::Client.new(:public_key => TEST_CREDENTIALS[:public_key], :private_key => TEST_CREDENTIALS[:private_key])
    end

end