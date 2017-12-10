require 'token_generator'

class TokenBuilder
  def self.build_token
    Token.new(token: TokenGenerator.get_next_token,
        token_expiration_date: TokenGenerator.get_next_token_expiration_date,
        refresh_token: TokenGenerator.get_next_refresh_token,
        refresh_token_expiration_date: TokenGenerator.get_next_refresh_token_expiration_date)
  end
end