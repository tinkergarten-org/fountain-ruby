module Fountain
  #
  # Fountain Document Signature
  #
  class DocumentSignature
    # Raw document signature data
    attr_reader :raw_data

    #
    # @param [Hash] data Raw document signature data
    #
    def initialize(data)
      @raw_data = Util.stringify_hash_keys data
    end

    # Signature ID
    def signature_id
      raw_data['signature_id']
    end

    # Vendor
    def vendor
      raw_data['vendor']
    end

    # Status
    def status
      raw_data['status']
    end

    def inspect
      format(
        '#<%<class_name>s:0x%<object_id>p @signature_id="%<signature_id>s">',
        class_name: self.class.name,
        object_id: object_id,
        signature_id: signature_id
      )
    end
  end
end
