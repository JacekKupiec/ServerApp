require 'digest'
require 'token_generator'
require 'token_builder'
require 'user_builder'

class UsersController < ApplicationController
  skip_before_action :custom_authenticate, only: [:create, :refresh, :log_in]

  DATE_FORMAT = '%Y-%m-%d %H:%m:%S %z'

  def create
    @user = UserBuilder.build_user(params)

    if @user.save
      render json: format_create_response(@user.tokens.first) , status: :created
    else
      render json: @user.errors.messages, status: :bad_request
    end
  end

  def refresh
    refresh_token = get_http_token
    old_token = Token.find_by!(refresh_token: refresh_token)

    if old_token.refresh_token_expiration_date > Time.now
      @token = get_token(old_token)
      @token.refresh_token_expiration_date = TokenGenerator.get_next_refresh_token_expiration_date

      if @token.save
        render json: format_refresh(@token), status: :ok
      else
        logger.fatal "Nie mogę zapisać tokena"
        render status: :internal_server_error
      end
    else
      response.headers['WWW-Authenticate'] = 'Token realm="Log In"'
      render json: { message: 'Bad refresh token' }, status: :unauthorized
    end
  end

  def log_in
    name, password = params[:user][:name], params[:user][:password]
    @user = User.find_by(name: name)
    old_ref_tok = get_http_token #Jeżeli podsyłam stary fefresh token to może nie muszę tworzyć nowego w bazie???

    if is_password_correct?(password, @user)
      @token, should_reload = get_refresh_token(@user, old_ref_tok)

      if @token.save
        render json: format_log_in(@token, should_reload), status: :ok
      else
        logger.fatal 'Nie mogę zapisać tokena, błąd logowania'
        render status: :internal_server_error
      end
    else
      response.headers['WWW-Authenticate'] = 'Token realm="Log In"'
      render json: { message: 'Bad login or password' }, status: :unauthorized
    end
  end

  def get_products
    @user = Token.find_by!(token: get_http_token).user
    render json: { products: products_to_hash(@user.products) }, status: :ok
  end

  private

  def is_password_correct?(new_pass, user)
    user.present? && Digest::SHA256.hexdigest(new_pass) == user.password_hash
  end

  def products_to_hash(products)
    products.map do |e|
      { id: e.id, name: e.name, store_name: e.store_name, price: e.price, amount: e.total_sum, guid: e.guid, brand: e.brand }
    end
  end

  def get_refresh_token(usr, old_ref_tok)
    tok = usr.tokens.find_by(refresh_token: old_ref_tok)

    if tok.present? && tok.refresh_token_expiration_date > Time.now
      return tok, false
    elsif !tok.present?
      tok = TokenBuilder.build_token
      tok.user = usr
      return tok, true
    else
      tok.refresh_token = TokenGenerator.get_next_refresh_token
      tok.refresh_token_expiration_date = TokenGenerator.get_next_refresh_token_expiration_date

      return tok, false
    end
  end

  def get_token(tok)
    if tok.token_expiration_date > Time.now
      return tok
    else
      tok.token = TokenGenerator.get_next_token
      tok.token_expiration_date = TokenGenerator.get_next_token_expiration_date

      return tok
    end
  end

  def get_http_token
    request.headers['Authorization'].split('=')[1]
  end

  def format_create_response(token)
    return { token: token.token,
             token_expiration_date: token.token_expiration_date.strftime(DATE_FORMAT),
             refresh_token: token.refresh_token,
             refresh_token_expiration_date: token.refresh_token_expiration_date.strftime(DATE_FORMAT),
             'should reload': true }
  end

  def format_refresh(token)
    return { token: token.token,
             token_expiration_date: token.token_expiration_date.strftime(DATE_FORMAT) }
  end

  def format_log_in(token, should_reload)
    return { refresh_token: token.refresh_token,
             refresh_token_expiration_date: token.refresh_token_expiration_date.strftime(DATE_FORMAT),
             'should reload': should_reload }
  end
end
