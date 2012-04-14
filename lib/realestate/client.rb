module Realestate
  class Client

    include HTTParty
    base_uri "/api.realestate.co.nz/#{Realestate::API_VERSION}/"

    attr_accessor :public_key, :private_key

    def initialize(options = {})
      self.public_key, self.private_key = options.delete(:public_key), options.delete(:private_key)

      unless self.public_key.present? && self.private_key.present?
        raise CredentialsRequired.new("You must specify your Public and Private keys")
      end
    end

  end
end