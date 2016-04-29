class AuthenticationSerializer < BaseSerializer
  attributes :user_id, :authentication_token, :authentication_token_expires_at

  def user_id
    object.id
  end
end
