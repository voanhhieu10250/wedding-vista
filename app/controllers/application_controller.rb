class ApplicationController < ActionController::Base
  helper_method :authenticate_admin!, :flash_errors_message

  rescue_from ActiveRecord::RecordNotFound do |error|
    respond_to do |format|
      format.json { render_json_error(OpenStruct.new(type: "RecordNotFound", message: error.message), :not_found) }
      format.html { render template: "errors/not_found", layout: "application", status: :not_found }
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

    render_flash(type: :error, message: "You are not authorized to access this page.")
    redirect_to root_path
  end
end
