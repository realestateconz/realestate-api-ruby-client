require 'active_support/all'
require 'httparty'
require 'digest/md5'
require 'cgi'

module Realestate

  # constants
  API_VERSION = 1

  # exceptions...
  class CredentialsRequired < StandardError; end
  class AuthenticationError < StandardError; end
  class ApiError < StandardError; end

end

require 'realestate/client'