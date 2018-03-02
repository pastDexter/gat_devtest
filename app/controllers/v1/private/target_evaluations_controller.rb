module V1
  module Private
    class TargetEvaluationsController < BaseController

      def create
        ev_params = TargetEvaluationParams.new(params)
        if ev_params.valid?
          pricing_logic = current_panel_provider.pricing_logic_class.new
          evaluator = TargetEvaluator.new(ev_params.locations, pricing_logic)
          render json: { price: evaluator.calculate_price }
        else
          render_error ev_params.errors.messages, 422
        end
      end

    end
  end
end