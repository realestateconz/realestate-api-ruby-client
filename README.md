Realestate.co.nz API Client for Ruby
====================================

[![Build Status](https://secure.travis-ci.org/nikz/realestate-ruby.png)](http://travis-ci.org/nikz/realestate-ruby)

*NB:* This API Client is currently under active development, things may change rapidly :)

All methods return the parsed JSON from the API, so this is usually an array of hashes. For documentation on
specific elements, see the PDF provided by Realestate.co.nz.

Creating a new client:

    client = Realestate::Client.new(:public_key => YOUR_PUBLIC_KEY, :private_key => YOUR_PRIVATE_KEY)
    #=> <RealEstate::Client...>

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