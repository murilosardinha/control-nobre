# frozen_string_literal: true

module Api
  class ApiController < ActionController::Base
    protect_from_forgery with: :null_session
    after_action :set_access_control_headers

    skip_before_action :verify_authenticity_token

    private

    def set_access_control_headers
      headers["Access-Control-Allow-Origin"] = "*"
      headers["Access-Control-Request-Method"] = %w[{GET POST OPTIONS}.join(",")]
    end
  end
end