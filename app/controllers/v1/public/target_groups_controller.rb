module V1
  module Public
    class TargetGroupsController < BaseController

      def index
        country = Country.find_by!(country_code: params[:country_code])
        root_target_groups = country.target_groups
        target_groups = root_target_groups.find_roots_with_children
        render json: target_groups, scope: { id_to_external: id_to_external(target_groups) }
      end

      private

      def id_to_external(target_groups)
        target_groups.map { |tg| [tg.id, tg.external_id] }.to_h
      end

    end
  end
end