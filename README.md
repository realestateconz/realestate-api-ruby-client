First cut of Realestate.co.nz API Client

Creating a new client:
<code>
  client = Realestate::Client.new(:public_key => YOUR_PUBLIC_KEY, :private_key => YOUR_PRIVATE_KEY)
  #=> <RealEstate::Client...>
</code>

Requesting a list of suburbs:
<code>
  client.suburbs
  #=> [ { id : 1234, name : "Test" .. } ]
</code>