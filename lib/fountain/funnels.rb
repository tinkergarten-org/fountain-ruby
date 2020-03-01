# frozen_string_literal: true

module Fountain
  #
  # Fountain Funnel collection
  #
  class Funnels
    extend Forwardable

    # Collection current page
    attr_reader :current_page

    # Collection last page
    attr_reader :last_page

    # Funnel collection
    attr_reader :funnels

    def_delegators :funnels, :each, :map, :count, :size, :[]

    #
    # @param [Hash] data Raw funnel data
    #
    def initialize(data)
      raw_data = Util.stringify_hash_keys data
      pagination = raw_data['pagination']
      if pagination.is_a? Hash
        @current_page = pagination['current']
        @last_page = pagination['last']
      end
      @funnels = raw_data['funnels'].map { |attr| Funnel.new attr }
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
