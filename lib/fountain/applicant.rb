# frozen_string_literal: true

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

    # Updated at
    def updated_at
      Time.parse raw_data['updated_at']
    end

    # Last transitioned at
    def last_transitioned_at
      Time.parse raw_data['last_transitioned_at']
    end

    # Email
    def email
      raw_data['email']
    end

    # Name
    def name
      raw_data['name']
    end

    # First name
    def first_name
      raw_data['first_name']
    end

    # Last name
    def last_name
      raw_data['last_name']
    end

    # Phone number
    def phone_number
      raw_data['phone_number']
    end

    # Normalized phone number
    def normalized_phone_number
      raw_data['normalized_phone_number']
    end

    # Is duplicate
    def duplicate?
      raw_data['is_duplicate']
    end

    # Receive automated emails
    def receive_automated_emails?
      raw_data['receive_automated_emails']
    end

    # Can receive sms
    def can_receive_sms?
      raw_data['can_receive_sms']
    end

    # Phone platform
    def phone_platform
      raw_data['phone_platform']
    end

    # Rejection reason
    def rejection_reason
      raw_data['rejection_reason']
    end

    # On hold reason
    def on_hold_reason
      raw_data['on_hold_reason']
    end

    # data
    def data
      raw_data['data']
    end

    # Addresses
    def addresses
      raw_data['addresses']
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
