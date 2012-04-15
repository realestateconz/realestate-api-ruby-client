Realestate.co.nz API Client for Ruby
====================================

[![Build Status](https://secure.travis-ci.org/nikz/realestate-ruby.png)](http://travis-ci.org/nikz/realestate-ruby)

*NB:* This API Client is currently under active development, things may change rapidly :)

All methods return the parsed JSON from the API, so this is usually an array of hashes. For documentation on
specific elements, see the PDF provided by Realestate.co.nz.

Creating a new client:

    client = Realestate::Client.new(:public_key => YOUR_PUBLIC_KEY, :private_key => YOUR_PRIVATE_KEY)
    #=> <Realestate::Client...>

Category methods (note that dashes in API paths are converted to underscores for Ruby method names):

    client.suburbs
    #=> [ { "id" => 3312, "name" => "Fiji" ... } ]

    client.districts
    #=> [ { "id" => 1, "name" => "Fiji" ... } ]

    client.regions
    #=> [ { "id" => 34, "name" => "Northland" ... } ]

    client.listing_types
    #=> [ { "id" => 1, "name" => "Residential" ... } ]

    client.pricing_methods
    #=> [ { "id" => 1, "name" => "Fixed Price" ... } ]

Listing searching, will concatenate pages automatically. Search paramters as per Realestate.co.nz documentation.

    client.listings(:district_id => 1, :format => "id")
    #=> [ { "id" : 1234, ... }]

The `Realestate::Image` class represents an image on the image server. You can create images via ID or URL:

    image = Realestate::Image.new(12345)
    # => <Realestate::Image... >

    image = Realestate::Image.new("http://imageserver.realestate.co.nz/1234")
    # => <Realestate::Image... >

You can download images using the download method, and the w/h/bg/mode parameters as per the documentation:

    image = Realestate::Image.new(12345)
    image.download(:w => 200, :h => 100)
    # => <IO ... >


