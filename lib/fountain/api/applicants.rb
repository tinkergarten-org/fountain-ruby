module Fountain
  module Api
    #
    # Fountain Applicant API
    #
    class Applicants
      include RequestHelper

      #
      # List applicants
      # @param [Hash] filter_options A hash of options to send to Fountain.
      #                 funnel_id - Unique identifier of the position/funnel
      #                 stage_id - Unique identifier of the stage
      #                 stage - Filter applicants by stage type
      #                 labels - MUST be URL-encoded
      #                 cursor - Cursor parameter for cursor-based pagination
      # @return [Array] of Fountain::Applicant
      def list(filter_options = {})
        response = request_json(
          '/v2/applicants',
          body: Util.slice_hash(
            filter_options,
            :funnel_id, :stage_id, :stage, :labels, :cursor
          )
        )
        Fountain::Applicants.new response
      end

      #
      # Update applicant info
      # @param [String] applicant_id ID of the Fountain applicant
      # @param [Hash] update_options A hash of options to update applicant
      #                 name
      #                 email
      #                 phone_number
      #                 data - must be passed in a data object/array
      #                 secure_data - See 'Secure Fields' section of
      #                               https://developer.fountain.com/docs/update-applicant-info
      #                 rejection_reason
      #                 on_hold_reason
      # @return [Fountain::Applicant]
      #
      def update(applicant_id, update_options = {})
        response = request_json(
          "/v2/applicants/#{applicant_id}",
          method: :put,
          body: Util.slice_hash(
            update_options,
            :name, :email, :phone_number, :data, :secure_data,
            :rejection_reason, :on_hold_reason
          )
        )
        Fountain::Applicant.new response
      end
    end
  end
end
