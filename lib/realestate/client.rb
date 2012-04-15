module Realestate
  class Client

    include HTTParty
    base_uri "http://api.realestate.co.nz/#{Realestate::API_VERSION}/"

    attr_accessor :public_key, :private_key

    def initialize(options = {})
      self.public_key, self.private_key = options.delete(:public_key), options.delete(:private_key)

      unless self.public_key.present? && self.private_key.present?
        raise CredentialsRequired.new("You must specify your Public and Private keys")
      end
    end

    %w(suburbs districts regions listing_types pricing_methods).each do |cat_name|
      define_method(cat_name) do
        request(:get, cat_name.dasherize)
      end
    end

    private

      def request(method, path, params = {})
        query = prepare_params(path, params).map { |x| x.join("=") }.join("&")
        process_response(self.class.send(method, "/#{path}/", :query => query))
      end

      # Adds necessary authentication parameters to the passed request parameters,
      # and returns the signed set of parameters
      #
      # These parameters are api_key and api_sig as per the "Authentication" section
      # in the API documentation
      #
      # @param params Hash - the parameters to sign
      # @returns Hash - a hash of signed parameters, plus the original params
      def prepare_params(request_path, params)
        # use multiple instances of the same param name for Array values
        params = params.inject([]) do |array, pair|
          Array.wrap(pair.last).each do |val|
            array << [ pair.first.to_s, CGI.escape(val.to_s) ]
          end
          array
        end

        params << ["api_sig", calculate_api_sig(request_path, params)]
        params << ["api_key", public_key ]
      end

      def calculate_api_sig(request_path, params_array)
        # Sort your URL argument list into alphabetical (ASCII) order based on the parameter name and value. e.g. a=B, foo=1, bar=2, baz=P, baz=3 sorts to a=B, bar=2, baz=3, baz=P, foo=1
        sorted_params = params_array.sort_by { |k, v| "#{k}-#{v}" }

        # Concatenate api secret, request path, sorted params
        concatenated_string = [ self.private_key, "#{Realestate::API_VERSION}", request_path, sorted_params.to_s ].join("/")

        Digest::MD5.hexdigest(concatenated_string)
      end

      def process_response(response)
        if response.success?
          response.parsed_response
        elsif response.code == 401
          raise AuthenticationError.new(response.body)
        end
      end


  end
end