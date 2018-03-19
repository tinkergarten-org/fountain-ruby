module Fountain
  #
  # Fountain Applicant collection
  #
  class Applicants
    extend Forwardable

    # Collection current cursor
    attr_reader :current_cursor

    # Collection next cursor
    attr_reader :next_cursor

    # Applicant collection
    attr_reader :applicants

    def_delegators :applicants, :each, :map, :count, :size, :[]

    #
    # @param [Hash] data Raw applicant data
    #
    def initialize(data)
      raw_data = Util.stringify_hash_keys data
      pagination = raw_data['pagination']
      if pagination.is_a? Hash
        @current_cursor = pagination['current_cursor']
        @next_cursor = pagination['next_cursor']
      end
      @applicants = raw_data['applicants'].map { |attr| Applicant.new attr }
    end
  end
end
