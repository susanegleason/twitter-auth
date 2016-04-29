require 'rails_helper'

describe TwitterAuthenticator do
  describe '.perform' do
    context 'with a user that does not exist' do
      before(:each) do
        stub_twitter_application_authorization_request
        stub_twitter_verify_new_user_credentials
      end
      it 'creates a new user' do
        expect(User.count).to eq(0)

        TwitterAuthenticator.perform(new_twitter_params)

        expect(User.count).to eq(1)
      end
      it 'sets the attributes on the user' do
        user = TwitterAuthenticator.perform(new_twitter_params)

        expect(user.twitter_uid).to be
        expect(user.twitter_user_name).to be
        expect(user.twitter_token).to be
        expect(user.authentication_token).to be
        expect(user.authentication_token_expires_at).to be
      end
    end

    context 'with a user that already exists' do
      before(:each) do
        stub_twitter_application_authorization_request
      end
      it 'does not create a new user' do
        user = create(:user)
        stub_twitter_verify_existing_user_credentials(user)

        expect(User.count).to eq(1)

        TwitterAuthenticator.perform(twitter_params(user))

        expect(User.count).to eq(1)
      end
      it 'returns the user' do
        user = create(:user)
        stub_twitter_verify_existing_user_credentials(user)

        twitter_auth = TwitterAuthenticator.perform(twitter_params(user))
        user.reload

        expect(twitter_auth).to eq(user)
      end
    end
  end

  def new_twitter_params
    { twitter_uid: '123456',
      twitter_token: '12334token' }
  end

  def twitter_params(user)
    { twitter_uid: user.twitter_uid,
      twitter_token: user.twitter_token }
  end
end
