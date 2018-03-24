module Fountain
  #
  # Fountain Stage
  #
  class Stage
    # Raw stage data
    attr_reader :raw_data

    #
    # @param [Hash] data Raw stage data
    #
    def initialize(data)
      @raw_data = Util.stringify_hash_keys data
    end

    # Stage ID
    def id
      raw_data['id']
    end

    # Title
    def title
      raw_data['title']
    end

    # Type
    def type
      raw_data['type']
    end

    def inspect
      format(
        '#<%<class_name>s:0x%<object_id>p @id="%<id>s" @title="%<title>s">',
        class_name: self.class.name,
        object_id: object_id,
        id: id,
        title: title
      )
    end
  end
end
