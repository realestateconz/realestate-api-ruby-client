require File.join(File.dirname(__FILE__), '../test_helper.rb')

# this file tests the live client
class LiveClientTest < ActiveSupport::TestCase

  setup do
    WebMock.disable!
  end

  teardown do
    WebMock.enable!
  end

  context "finding and downloading a live image" do
    setup do
      @client = create_test_client
    end

    should "work" do
      listing       = @client.listings(:district_id => 1).first
      listing_image = Realestate::Image.new(listing["images"].first)

      begin
        file = listing_image.download
        assert (file.size > 0)
      ensure
        file.unlink if file
      end

    end

  end

  private

    def create_test_client
      Realestate::Client.new(:public_key => TEST_CREDENTIALS[:public_key], :private_key => TEST_CREDENTIALS[:private_key])
    end

end