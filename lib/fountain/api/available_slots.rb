module Fountain
  module Api
    #
    # Fountain Slot Management API
    #
    class AvailableSlots
      extend RequestHelper

      #
      # Confirm an available slot
      # @param [String] available_slot_id ID of the Fountain slot
      # @param [String] applicant_id ID of the Fountain applicant
      # @return [Fountain::Slot]
      def self.confirm(available_slot_id, applicant_id)
        response = request_json(
          "/v2/available_slots/#{available_slot_id}/confirm",
          method: :post,
          body: { applicant_id: applicant_id }
        )
        Fountain::Slot.new response
      end

      #
      # List Available Slots
      # @param [String] stage_id ID of the Fountain stage
      # @return [[Fountain::Slots]]
      def self.list(stage_id, list_options = {})
        page_query = list_options[:page] ? "?page=#{list_options[:page]}" : ''
        response = request_json(
          "/v2/stages/#{stage_id}/available_slots#{page_query}"
        )
        Fountain::Slots.new response
      end

      #
      # Cancel a booked session
      # @param [String] booked_slot_id ID of the Fountain slot
      # @param [String] applicant_id ID of the Fountain applicant
      # @return [Fountain::Slot]
      def self.cancel(booked_slot_id)
        response = request(
          "/v2/booked_slots/#{booked_slot_id}/cancel",
          method: :post
        )
        check_response response
        true
      end
    end
  end
end
