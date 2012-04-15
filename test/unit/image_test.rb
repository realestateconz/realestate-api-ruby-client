require File.join(File.dirname(__FILE__), '../test_helper.rb')

class ImageTest < ActiveSupport::TestCase

  context "with a new image" do
    setup do
      @image = Realestate::Image.new(123)
    end

    should "return a convincing looking url" do
      assert_equal "http://imageserver.realestate.co.nz/id/123",       @image.url
      assert_equal "http://imageserver.realestate.co.nz/id/123?w=200", @image.url(:w => 200)
    end

    should "be able to download image" do
      nyan_cat = File.open(File.join(File.dirname(__FILE__), "..", "fixtures", "nyan-cat.gif"))

      stub_request(:get, "http://imageserver.realestate.co.nz/id/123").to_return(:body => nyan_cat)

      downloaded_nyan_cat = @image.download

      assert_equal Digest::MD5.file(nyan_cat.path), Digest::MD5.file(downloaded_nyan_cat.path)
    end

  end

end