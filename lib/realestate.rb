require 'active_support'
require 'httparty'
require 'realestate/client'

module Realestate

  # constants
  API_VERSION = 1

  # exceptions...
  class CredentialsRequired < StandardError; end

end