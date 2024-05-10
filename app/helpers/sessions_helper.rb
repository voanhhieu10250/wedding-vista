module SessionsHelper
  def admin?
    current_user.is_admin?
  end
end
