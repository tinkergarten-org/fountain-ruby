# frozen_string_literal: true

module Fountain
  #
  # Fountain Label
  #
  class Label
    # Raw label data
    attr_reader :raw_data

    #
    # @param [Hash] data Raw label data
    #
    def initialize(data)
      @raw_data = Util.stringify_hash_keys data
    end

    # Label title
    def title
      raw_data['title']
    end

    # Completed
    def completed
      raw_data['completed']
    end

    def inspect
      format(
        '#<%<class_name>s:0x%<object_id>p @title="%<title>s">',
        class_name: self.class.name,
        object_id: object_id,
        title: title
      )
    end
  end
end
