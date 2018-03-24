require 'date'
require 'cgi'

module Fountain
  module Api
    #
    # Fountain Label Management API
    #
    class Labels
      extend RequestHelper

      #
      # List Labels for an Applicant
      # @param [String] applicant_id ID of the Fountain applicant
      # @return [[Fountain::Label]]
      def self.applicant_labels(applicant_id)
        response = request_json("/v2/applicants/#{applicant_id}/labels")
        response['labels'].map { |hash| Fountain::Label.new hash }
      end

      #
      # Update Label for an Applicant
      # @param [String] applicant_id ID of the Fountain applicant
      # @param [String] title ID of the Fountain applicant
      # @param [Hash] update_options A hash of options to update applicant labels
      #                 completed
      #                 completed_at - Date the label was completed
      # @return [[Fountain::Label]]
      def self.update_applicant_label(applicant_id, title, update_options = {})
        filtered_options = Util.slice_hash(update_options, :completed, :completed_at)
        if filtered_options[:completed_at].is_a? Date
          filtered_options[:completed_at] = filtered_options[:completed_at].strftime('%F')
        end
        response = request_json(
          "/v2/applicants/#{applicant_id}/labels/#{CGI.escape(title)}",
          method: :put,
          body: filtered_options
        )
        response['labels'].map { |hash| Fountain::Label.new hash }
      end

      #
      # List Labels for a Stage
      # @param [String] stage_id ID of the Fountain stage
      # @return [[Fountain::Label]]
      def self.stage_labels(stage_id)
        response = request_json("/v2/stages/#{stage_id}/labels")
        response['labels'].map { |hash| Fountain::Label.new hash }
      end
    end
  end
end
