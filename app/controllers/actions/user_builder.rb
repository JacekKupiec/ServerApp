require 'token_generator'

class UserBuilder
  def self.build_user(params)
    user = User.new(params.require(:user).permit(:name))
    user.password_hash = Digest::SHA256.hexdigest(params[:user][:password])

    tok = TokenBuilder.build_token

    user.tokens << tok

    return user
  end
end