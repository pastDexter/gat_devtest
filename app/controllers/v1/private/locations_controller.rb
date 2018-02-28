module V1
  module Private
    class LocationsController < BaseController

      def index
        panel_provider = PanelProvider.first
        country = Country.find_by!(country_code: params[:country_code])
        locations = Location.joins(location_groups: [:country, :panel_provider]).where(location_groups: { panel_provider: panel_provider, country: country })

        render json: locations.as_json(only: [:name, :external_id, :secret_code])
      end

    end
  end
end