module Fountain
  module Api
    #
    # Fountain Note Management API
    #
    class Notes
      extend RequestHelper

      #
      # List Notes for an Applicant
      # @param [String] applicant_id ID of the Fountain applicant
      # @return [[Fountain::Note]]
      def self.list(applicant_id)
        response = request_json("/v2/applicants/#{applicant_id}/notes")
        response['notes'].map { |hash| Fountain::Note.new hash }
      end

      #
      # Create a Note for an Applicant
      # @param [String] applicant_id ID of the Fountain applicant
      # @param [String] content Content for the note
      # @return [Fountain::Note]
      def self.create(applicant_id, content)
        response = request_json(
          "/v2/applicants/#{applicant_id}/notes",
          method: :post,
          body: { content: content }
        )
        Fountain::Note.new response
      end

      #
      # Delete Applicant Note
      # @param [String] applicant_id ID of the Fountain applicant
      # @param [String] note_id ID of the Fountain note
      # @return [Boolean]
      def self.delete(applicant_id, note_id)
        response = request(
          "/v2/applicants/#{applicant_id}/notes/#{note_id}",
          method: :delete
        )
        check_response response
        true
      end

      #
      # Update Applicant Note
      # @param [String] applicant_id ID of the Fountain applicant
      # @param [String] note_id ID of the Fountain note
      # @param [String] content Content for the note
      # @return [Fountain::Note]
      def self.update(applicant_id, note_id, content)
        response = request_json(
          "/v2/applicants/#{applicant_id}/notes/#{note_id}",
          method: :put,
          body: { content: content }
        )
        Fountain::Note.new response
      end
    end
  end
end
