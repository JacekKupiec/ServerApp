class ApplicationController < ActionController::API
  before_action :custom_authenticate
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  include ActionController::HttpAuthentication::Token::ControllerMethods

  private
  def custom_authenticate
    authenticate_token || bad_credentials
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      tok = Token.find_by(token: token)
      tok.present? && tok.token_expiration_date > Time.now
    end
  end

  def bad_credentials
    self.headers['WWW-Authenticate'] = 'Token realm="Refresh"'
    render json: { message: 'Bad access token' }, status: :unauthorized
  end

  def record_not_found
    render json: { message: 'Requested resource not found' }, status: :not_found
  end
end
