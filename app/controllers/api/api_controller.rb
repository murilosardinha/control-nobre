# frozen_string_literal: true

module Api
  class ApiController < ActionController::Base
    protect_from_forgery with: :null_session
    after_action :set_access_control_headers

    skip_before_action :verify_authenticity_token

    def format_number(number)
      return 0 unless number.present?
      return number if number.class == Integer
  
      number.gsub(/\,/mi, '.').to_f
    end

    def format_decimal(number)
      return 0 unless number.present?
      return number if number.class == Integer
  
      number.gsub(/\./mi, '').to_f
    end

    private

    def set_access_control_headers
      headers["Access-Control-Allow-Origin"] = "*"
      headers["Access-Control-Request-Method"] = %w[{GET POST OPTIONS}.join(",")]
    end
  end
end