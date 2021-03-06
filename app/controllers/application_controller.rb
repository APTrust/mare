class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # TODO: Remove this when cancan is capable of handing strong_parameters.
  # See https://github.com/ryanb/cancan/issues/835
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  # If a User is denied access for an action, return them back to the last page they could view.
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "#{exception}"
    redirect_to root_path
  end
end
