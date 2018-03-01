module V1
  module Private
    class AuthorizationsController < BaseController
      skip_before_action :authorize_panel_provider!

      def create
        panel_provider = PanelProvider.find_by!(code: params[:code])
        token = panel_provider.access_tokens.new
        token.key = SecureRandom.uuid
        token.expiration_date = 2.days.from_now
        render json: token
      end

    end
  end
end