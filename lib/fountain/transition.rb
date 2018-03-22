module Fountain
  #
  # Fountain Transition
  #
  class Transition
    # Raw transition data
    attr_reader :raw_data

    #
    # @param [Hash] data Raw transition data
    #
    def initialize(data)
      @raw_data = Util.stringify_hash_keys data
    end

    # Stage title
    def stage_title
      raw_data['stage_title']
    end

    # Created at
    def created_at
      Time.parse raw_data['created_at']
    end

    def inspect
      format(
        '#<%<class_name>s:0x%<object_id>p @stage_title="%<title>s">',
        class_name: self.class.name,
        object_id: object_id,
        title: stage_title
      )
    end
  end
end
