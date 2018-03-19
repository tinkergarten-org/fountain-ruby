module Fountain
  #
  # Fountain Applicant
  #
  class Applicant
    # Raw applicant data
    attr_reader :raw_data

    #
    # @param [Hash] data Raw applicant data
    #
    def initialize(data)
      @raw_data = Util.stringify_hash_keys data
    end

    # Applicant ID
    def id
      raw_data['id']
    end

    # Created at
    def created_at
      Time.parse raw_data['created_at']
    end

    # Email
    def email
      raw_data['email']
    end

    # Name
    def name
      raw_data['name']
    end

    # Phone number
    def phone_number
      raw_data['phone_number']
    end

    # data
    def data
      raw_data['data']
    end

    # Funnel
    def funnel
      Funnel.new raw_data['funnel']
    end

    # Stage
    def stage
      Stage.new raw_data['stage']
    end

    # Background checks
    def background_checks
      return [] unless raw_data['background_checks'].is_a? Array
      raw_data['background_checks'].map { |check| BackgroundCheck.new check }
    end

    # Document signatures
    def document_signatures
      return [] unless raw_data['document_signatures'].is_a? Array
      raw_data['document_signatures'].map { |signature| DocumentSignature.new signature }
    end

    def inspect
      format(
        '#<%<class_name>s:0x%<object_id>p @id="%<id>s" @name="%<name>s" @email="%<email>s">',
        class_name: self.class.name,
        object_id: object_id,
        id: id,
        name: name,
        email: email
      )
    end
  end
end
