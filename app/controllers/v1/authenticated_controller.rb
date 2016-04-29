class V1::AuthenticatedController < V1::ApiController
  def current_user
    request.env['warden'].user
  end
end
