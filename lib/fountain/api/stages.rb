# frozen_string_literal: true

module Fountain
  module Api
    #
    # Fountain Stage Management API
    #
    class Stages
      extend RequestHelper

      #
      # Get Stage Info
      # @param [String] stage_id ID of the Fountain stage
      # @return [Fountain::Stage]
      def self.get(stage_id)
        response = request_json("/v2/stages/#{stage_id}")
        Fountain::Stage.new response
      end
    end
  end
end
