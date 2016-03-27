class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  # before_action :authenticate
  before_action :set_jbuilder_defaults
  
  protected
  
  def set_jbuilder_defaults
    @errors = []
  end
  
  def error!(message, status)
    @errors << message
    response.status = status
    render template: "api/v1/errors"
  end
  
  def error_array!(array, status)
    @errors += array
    response.status = status
    render template: "api/v1/errors"
  end

  def authenticate_owner(owner)
    if owner != @current_user
      error!("No tiene autorizado editar este recurso", :unauthorized)
#      render json: {errors: "No tiene autorizado editar este recurso" }, status:  :unauthorized
    end
  end

  def authenticate
    #@current_user = User.first
    token_str = params[:token]
    token = Token.find_by(token: token_str)
    if token.nil? || !token.is_valid?
#      render json: { error: "Tu token es inválido", status: :unauthorized }
      error!("Tu token es inválido", :unauthorized)
    else
      @current_user = token.user
    end

  end


end


#http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
