class ApplicationController < ActionController::Base
  helper_method :render_flash, :authenticate_admin!

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.is_admin?
      admin_root_path
    else
      super
    end
  end

  def render_flash(type: :sucess, message: "")
    flash[type] = message unless message.blank?
    turbo_stream.update "turbo-flash", partial: "shared/flash"
  end

  def authenticate_admin!
    return if current_user&.is_admin?

    render_flash(type: :error, message: "You are not authorized to access this page.")
    redirect_to root_path
  end
end
