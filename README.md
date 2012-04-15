First cut of Realestate.co.nz API Client

Creating a new client:

    client = Realestate::Client.new(:public_key => YOUR_PUBLIC_KEY, :private_key => YOUR_PRIVATE_KEY)
    #=> <RealEstate::Client...>

Requesting a list of suburbs:

    client.suburbs
    #=> [ { id : 1234, name : "Test" .. } ]