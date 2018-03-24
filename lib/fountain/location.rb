module Fountain
  #
  # Fountain Location
  #
  class Location
    # Raw location data
    attr_reader :raw_data

    #
    # @param [Hash] data Raw location data
    #
    def initialize(data)
      @raw_data = Util.stringify_hash_keys data
    end

    # Location ID
    def id
      raw_data['id']
    end

    # Name
    def name
      raw_data['name']
    end
  end
end
