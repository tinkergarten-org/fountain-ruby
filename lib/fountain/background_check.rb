module Fountain
  #
  # Fountain Background Check
  #
  class BackgroundCheck
    # Raw background check data
    attr_reader :raw_data

    #
    # @param [Hash] data Raw background check data
    #
    def initialize(data)
      @raw_data = Util.stringify_hash_keys data
    end

    # Title
    def title
      raw_data['title']
    end

    # Status
    def status
      raw_data['status']
    end

    # Vendor
    def vendor
      raw_data['vendor']
    end

    # Candidate ID
    def candidate_id
      raw_data['candidate_id']
    end

    # Report ID
    def report_id
      raw_data['report_id']
    end

    def inspect
      format(
        '#<%<class_name>s:0x%<object_id>p @title="%<title>s" @status="%<status>s">',
        class_name: self.class.name,
        object_id: object_id,
        title: title,
        status: status
      )
    end
  end
end
