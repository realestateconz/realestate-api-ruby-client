module Realestate
  require 'open-uri'
  require 'tempfile'

  class Image

    @@base_uri = "http://imageserver.realestate.co.nz/id/"
    attr_accessor :id

    def initialize(id)
      @id = id
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