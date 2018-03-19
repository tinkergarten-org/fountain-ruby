module Fountain
  #
  # Fountain Funnel
  #
  class Funnel
    # Raw funnel data
    attr_reader :raw_data

    #
    # @param [Hash] data Raw funnel data
    #
    def initialize(data)
      @raw_data = Util.stringify_hash_keys data
    end

    # Funnel ID
    def id
      raw_data['id']
    end

    # Title
    def title
      raw_data['title']
    end

    # Custom ID
    def custom_id
      raw_data['custom_id']
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
