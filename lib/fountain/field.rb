module Fountain
  #
  # Fountain Field
  #
  class Field
    # Raw field data
    attr_reader :raw_data

    #
    # @param [Hash] data Raw field data
    #
    def initialize(data)
      @raw_data = Util.stringify_hash_keys data
    end

    # Question
    def question
      raw_data['question']
    end

    # Type
    def type
      raw_data['type']
    end

    # Key
    def key
      raw_data['key']
    end

    def inspect
      format(
        '#<%<class_name>s:0x%<object_id>p @type="%<type>s" @question="%<title>s">',
        class_name: self.class.name,
        object_id: object_id,
        type: type,
        question: question
      )
    end
  end
end
