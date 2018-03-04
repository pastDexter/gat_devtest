class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :render_not_found

  def render_not_found(ex)
    render_error(ex.message, :not_found)
  end

  def render_error(message, status)
    render(json: { errors: message }, status: status)
  end

end
