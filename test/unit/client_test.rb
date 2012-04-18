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
      stub_request(:get, "http://api.realestate.co.nz/1/suburbs/")\
        .with(:query => { :api_sig => "a9c0f5009e9e2bf1f61acd10b6c2640c", :api_key => "123" })\
        .to_return(:body => fixture_file("suburbs.json"), :headers => { "Content-Type" => "text/json" })

      results = @client.suburbs

      assert results.is_a?(Array)
      assert_equal 1821, results.size
      assert_equal "Fiji", results.first["name"]
    end
  end

  context "requesting listings" do
    setup do
      @client = create_test_client
    end

    should "return all pages with pagination" do

      # first page request
      stub_request(:get, "http://api.realestate.co.nz/1/listings/")\
        .with(:query => { :api_sig => "30f4a7600709c2fe2af38fb2074d6cb9", :format => "id",
                          :district_id => "1", :api_key => "123", :max_results => "20" })\
        .to_return(:body    => fixture_file("listings_page_1.json"),
                   :headers => { "Content-Type" => "text/json" })

      # second page request - need to do it like this rather than chaining to_return as
      # the API sig changes when we add the offset call :)
      stub_request(:get, "http://api.realestate.co.nz/1/listings/")\
        .with(:query => { :api_sig => "e7d26b8c64dbe017b0a9b5a7cf0502c2", :format => "id",
                          :district_id => "1", :api_key => "123", :max_results => "20", :offset => "20" })\
        .to_return(:body    => fixture_file("listings_page_2.json"),
                   :headers => { "Content-Type" => "text/json" })

      results = @client.listings(:district_id => 1, :format => "id", :max_results => 20)

      assert results.is_a?(Array)
      assert_equal 24, results.size
      assert_equal 1222760, results.first["id"]
    end

    should "be able to get the details of an individual listing" do

      stub_request(:get, "http://api.realestate.co.nz/1/listings/1759612/")\
        .with(:query => { :api_sig => "583c8eee3680297a6c7fba313328c662", :format => "basic", :api_key => "123" })\
        .to_return(:body    => fixture_file("listing_detail.json"),
                   :headers => { "Content-Type" => "text/json" })

      results = @client.listing(1759612)

      assert_equal "Vendors Gone!", results["teaser"]
      assert_equal ["5 Laurel Lane","Linwood","Christchurch City","Canterbury"], results["address"]["text"]
    end
  end


  private

    def create_test_client
      Realestate::Client.new(:public_key => "123", :private_key => "456")
    end

end