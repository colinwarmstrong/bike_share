class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :admin_user?, :resest_current_user
  before_action :set_cart

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin_user?
    current_user && current_user.admin?
  end

  def set_cart
    @cart ||= Cart.new(session[:cart])
  end

  def require_registered_user
    render file: "/public/404", layout: false unless current_user
  end

  def require_admin_user
    render file: "/public/404", layout: false unless admin_user?
  end
end
