module Fountain
  #
  # Fountain Note
  #
  class Note
    # Raw note data
    attr_reader :raw_data

    #
    # @param [Hash] data Raw note data
    #
    def initialize(data)
      @raw_data = Util.stringify_hash_keys data
    end

    # Note ID
    def id
      raw_data['id']
    end

    # Content
    def content
      raw_data['content']
    end

    # Created at
    def created_at
      Time.parse raw_data['created_at']
    end

    # Updated at
    def updated_at
      Time.parse raw_data['updated_at']
    end

    # User
    def user
      return unless raw_data['user'].is_a? Hash
      User.new raw_data['user']
    end

    def inspect
      format(
        '#<%<class_name>s:0x%<object_id>p @id="%<id>s">',
        class_name: self.class.name,
        object_id: object_id,
        id: id
      )
    end
  end
end
