# frozen_string_literal: true

module Fountain
  #
  # Fountain Slot collection
  #
  class Slots
    extend Forwardable

    # Collection current page
    attr_reader :current_page

    # Collection last page
    attr_reader :last_page

    # Slot collection
    attr_reader :slots

    def_delegators :slots, :each, :map, :count, :size, :[]

    #
    # @param [Hash] data Raw slot data
    #
    def initialize(data)
      raw_data = Util.stringify_hash_keys data
      pagination = raw_data['pagination']
      if pagination.is_a? Hash
        @current_page = pagination['current']
        @last_page = pagination['last']
      end
      @slots = raw_data['slots'].map { |attr| Slot.new attr }
    end

    def inspect
      format(
        '#<%<class_name>s:0x%<object_id>p @count="%<count>s">',
        class_name: self.class.name,
        object_id: object_id,
        count: count
      )
    end
  end
end
