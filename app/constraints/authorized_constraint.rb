class AuthorizedConstraint
  def matches?(request)
    warden = request.env['warden']
    warden && warden.authenticate!(:token_authentication_strategy)
  end
end
