# frozen_string_literal: true

module Fountain
  module Api
    #
    # Fountain Funnel Management API
    #
    class Funnels
      extend RequestHelper

      #
      # List all Funnels
      # @param [Hash] list_options A hash of options when listing funnels
      # @return [Fountain::Funnels]
      def self.list(list_options = {})
        page_query = list_options[:page] ? "?page=#{list_options[:page]}" : ''
        response = request_json("/v2/funnels#{page_query}")
        Fountain::Funnels.new response
      end

      #
      # Get Funnel Info
      # @param [String] funnel_id ID of the Fountain funnel
      # @return [Fountain::Funnel]
      def self.get(funnel_id)
        response = request_json("/v2/funnels/#{funnel_id}")
        Fountain::Funnel.new response
      end

      #
      # Update Funnel
      # @param [String] funnel_id ID of the Fountain funnel
      # @param [Hash] update_options A hash of options when updating a funnel
      #                 custom_id
      # @return [Fountain::Funnel]
      def self.update(funnel_id, update_options = {})
        response = request_json(
          "/v2/funnels/#{funnel_id}",
          method: :put,
          body: Util.slice_hash(update_options, :custom_id)
        )
        Fountain::Funnel.new response
      end

      #
      # List all Funnel stages
      # @param [String] funnel_id ID of the Fountain funnel
      # @return [[Fountain::Stage]]
      def self.list_stages(funnel_id)
        response = request_json("/v2/funnels/#{funnel_id}/stages")
        response['stages'].map { |hash| Fountain::Stage.new hash }
      end
    end
  end
end
