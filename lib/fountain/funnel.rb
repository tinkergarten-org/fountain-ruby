# frozen_string_literal: true

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

    # Address
    def address
      raw_data['address']
    end

    # Time zone
    def time_zone
      raw_data['time_zone']
    end

    # Description
    def description
      raw_data['description']
    end

    # Requirements
    def requirements
      raw_data['requirements']
    end

    # Fields
    def fields
      return [] unless raw_data['fields'].is_a? Array

      raw_data['fields'].map { |hash| Field.new hash }
    end

    # Stages
    def stages
      return [] unless raw_data['stages'].is_a? Array

      raw_data['stages'].map { |hash| Stage.new hash }
    end

    # Private
    def private?
      raw_data['is_private']
    end

    # Active
    def active?
      raw_data['active']
    end

    # Location
    def location
      return unless raw_data['location'].is_a? Hash

      Location.new raw_data['location']
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
