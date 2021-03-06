module V1
  module Public
    class LocationsController < BaseController

      def index
        country = Country.find_by!(country_code: params[:country_code])
        locations = Location.for_country(country).includes(:location_groups)
        render json: locations
      end

    end
  end
end