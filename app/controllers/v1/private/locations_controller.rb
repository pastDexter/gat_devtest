module V1
  module Private
    class LocationsController < BaseController

      def index
        country = Country.find_by!(country_code: params[:country_code])
        locations = Location.for_panel_provider(current_panel_provider).for_country(country)

        render json: locations
      end

    end
  end
end