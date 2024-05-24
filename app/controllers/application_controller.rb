class ApplicationController < ActionController::Base
  helper_method :authenticate_admin!, :flash_errors_message

  rescue_from ActiveRecord::RecordNotFound do |error|
    respond_to do |format|
      format.json { render_json_error(OpenStruct.new(type: "RecordNotFound", message: error.message), :not_found) }
      format.html { render template: "errors/not_found", layout: "application", status: :not_found }
    end
  end

  rescue_from PayOSError do |error|
    Rails.logger.error(error)
    respond_to do |format|
      if error.code == "101"
        format.json do
          render_json_error(
            OpenStruct.new(type: "NotFound", message: error.message),
            :not_found
          )
        end
        format.html { render template: "errors/not_found", layout: "application", status: :not_found }
      else
        format.json do
          render_json_error(
            OpenStruct.new(type: "INTERNAL_SERVER_ERROR", message: error.message),
            :internal_server_error
          )
        end
        format.html { render template: "errors/payos", layout: "application", status: :internal_server_error }
      end
    end
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.is_admin?
      admin_root_path
    else
      super
    end
  end

  def flash_errors_message(object, now: false)
    errors_message = object.errors.full_messages.join(". ")

    if now
      flash.now[:error] = errors_message
    else
      flash[:error] = errors_message
    end
  end

  def authenticate_admin!
    return if current_user&.is_admin?

    flash[:error] = "You are not authorized to access this page."
    redirect_to root_path
  end

  def render_json_error(error, status)
    render json: { type: error.type, message: error.message }, status:
  end
end
