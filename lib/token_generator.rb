require 'securerandom'

class TokenGenerator
  SEC_RND_TOKEN_LEN = 120
  SEC_RND_REF_TOKEN_LEN = 120

  def self.get_next_token
    SecureRandom.hex(SEC_RND_TOKEN_LEN)
  end

  def self.get_next_token_expiration_date
    Time.now + 1.hour
  end

  def self.get_next_refresh_token
    SecureRandom.hex(SEC_RND_REF_TOKEN_LEN)
  end

  def self.get_next_refresh_token_expiration_date
    Time.now + 3.weeks
  end
end