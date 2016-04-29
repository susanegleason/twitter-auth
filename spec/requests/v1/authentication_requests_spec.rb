require 'rails_helper'

describe 'Authentication requests' do
  describe 'POST /authentications' do
    context 'with valid attributes' do
      context 'such as a twitter token' do
        it 'calls TwitterAuthenticator.perform' do
          user = create(:user)

          allow(TwitterAuthenticator).to receive(:perform).with(twitter_attributes(user))

          post(authentications_url, twitter_authentication_parameters(user),
               accept_headers)

          expect(TwitterAuthenticator).to have_received(:perform)
        end
      end
    end

    context 'with invalid attributes' do
      context 'such as no token' do
        it 'returns a bad request error' do
          stub_twitter_application_authorization_request
          stub_twitter_verify_invalid_user_credentials
          empty_parameters = { user: { twitter_token: '' } }.to_json

          post(authentications_url, empty_parameters, accept_headers)

          expect(response).to have_http_status :bad_request
        end
      end
    end
  end
end

def twitter_authentication_parameters(user)
  { user: { twitter_token: user.twitter_token,
    twitter_secret: user.twitter_secret,
    twitter_uid: user.twitter_uid }}.to_json
end

def twitter_attributes(user)
  { twitter_token: user.twitter_token,
    twitter_secret: user.twitter_secret,
    twitter_uid: user.twitter_uid }
end

def accept_headers
  { 'Accept' => 'application/vnd.twitterphotosserver.com+json; version=1',
    'Content-Type' => 'application/json' }
end
