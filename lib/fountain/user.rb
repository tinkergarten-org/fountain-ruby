module Fountain
  #
  # Fountain User
  #
  class User
    # Raw user data
    attr_reader :raw_data

    #
    # @param [Hash] data Raw user data
    #
    def initialize(data)
      @raw_data = Util.stringify_hash_keys data
    end

    # User ID
    def id
      raw_data['id']
    end

    # Name
    def name
      raw_data['name']
    end

    # Email
    def email
      raw_data['email']
    end

    def inspect
      format(
        '#<%<class_name>s:0x%<object_id>p @id="%<id>s" @name="%<name>s">',
        class_name: self.class.name,
        object_id: object_id,
        id: id,
        name: name
      )
    end
  end
end
