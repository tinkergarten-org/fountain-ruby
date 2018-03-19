#
# Fountain configuration
#
module Fountain
  class << self
    # The path of the Fountain host
    attr_accessor :host_path

    # API token for Fountain
    attr_accessor :api_token

    def configure
      yield self if block_given?
    end
  end

  # Set default values for options
  @host_path = 'https://api.fountain.com'
end
