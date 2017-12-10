require 'securerandom'

module TokenGenerator
  SEC_RND_TOKEN_LEN = 120
  SEC_RND_REF_TOKEN_LEN = 120

  ACCESS_TOKEN_EXPIRATION_TIME = 1.hour
  REFERSH_TOKEN_EXPIRATION_TIME = 3.weeks

  def self.get_next_token
    SecureRandom.hex(SEC_RND_TOKEN_LEN)
  end

  def self.get_next_token_expiration_date
    Time.now + ACCESS_TOKEN_EXPIRATION_TIME
  end

  def self.get_next_refresh_token
    SecureRandom.hex(SEC_RND_REF_TOKEN_LEN)
  end

  def self.get_next_refresh_token_expiration_date
    Time.now + REFERSH_TOKEN_EXPIRATION_TIME
  end
end