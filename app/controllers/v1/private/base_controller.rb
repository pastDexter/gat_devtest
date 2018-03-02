module V1
  module Private
    class BaseController < ApplicationController

      before_action :authorize_panel_provider!

      protected

      def current_panel_provider
        @_panel_provider
      end

      def authorize_panel_provider!
        token = AccessToken.find_by(key: request.authorization)
        render_error({ access_token: ['is invalid'] }, :unauthorized) && return unless token
        render_error({ access_token: ['is expired'] }, :unauthorized) if token.expired?
        @_panel_provider = token.panel_provider
      end

    end
  end
end