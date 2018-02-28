class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def render_not_found(ex)
    render json: { error: ex.message }, status: :not_found
  end

end
