module Fountain
  #
  # Fountain Secure Document
  #
  class SecureDocument
    # Raw document data
    attr_reader :raw_data

    #
    # @param [Hash] data Raw secure document data
    #
    def initialize(data)
      @raw_data = Util.stringify_hash_keys data
    end

    # Secure document ID
    def id
      raw_data['id']
    end

    # Name
    def name
      raw_data['name']
    end

    # FriendlyName
    def friendly_name
      raw_data['friendly_name']
    end

    # Filename
    def filename
      raw_data['filename']
    end

    # Public URL
    def public_url
      raw_data['public_url']
    end

    # Size
    def size
      raw_data['size']
    end

    # Stage
    def stage
      Stage.new raw_data['stage']
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
