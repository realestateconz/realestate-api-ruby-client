module Realestate
  require 'open-uri'
  require 'tempfile'

  class Image

    @@base_uri = "http://imageserver.realestate.co.nz/id/"
    attr_accessor :id

    def initialize(id_or_url)
      if id_or_url.to_s =~ /\A[0-9]+\Z/
        @id = id_or_url.to_i
      else
        @id = id_or_url.scan(/\/id\/([0-9]+)/).flatten.first.to_i
      end
    end

    def url(options = {})
      options.symbolize_keys!.assert_valid_keys(:w, :h, :mode, :bg)
      "#{@@base_uri}#{id}#{"?" + options.to_param if options.present?}"
    end

    def download(options = {})
      open(URI.parse(url(options)))
    end

  end
end