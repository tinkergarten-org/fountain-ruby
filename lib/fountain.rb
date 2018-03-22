require 'fountain/gem_version'

require 'json'

require 'fountain/configuration'
require 'fountain/util'

module Fountain
  class Error < StandardError; end
  class HTTPError < Error; end
  class NotFoundError < HTTPError; end
  class AuthenticationError < HTTPError; end
  class InvalidMethodError < HTTPError; end
  class JsonParseError < Error; end
  class MissingApiKeyError < Error; end
  class StatusError < Error; end
end

require 'fountain/applicant'
require 'fountain/applicants'
require 'fountain/background_check'
require 'fountain/document_signature'
require 'fountain/funnel'
require 'fountain/secure_document'
require 'fountain/stage'

require 'fountain/api/request_helper'
require 'fountain/api/applicants'
