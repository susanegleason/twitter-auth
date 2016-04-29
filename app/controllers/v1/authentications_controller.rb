class V1::AuthenticationsController < V1::ApiController
  def create
    render json: TwitterAuthenticator.perform(user_params),
           serializer: AuthenticationSerializer
  end

  private

  def user_params
    params.require(:user).permit(:twitter_token, :twitter_uid, :twitter_secret)
  end
end
