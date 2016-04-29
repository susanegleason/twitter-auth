require 'rails_helper'

describe AuthenticationToken do
  describe '.generate' do
    it 'makes a secure token' do
      expect(AuthenticationToken.generate).to be_a String
    end
  end

  describe '.expires_at' do
    it 'sets an expiration timestamp' do
      expect(AuthenticationToken.expires_at).to be_a Time
    end

    it 'is valid for 30 days' do
      expect(AuthenticationToken.expires_at).
        to be_within(1).of(token_expiration_date)
    end
  end

  describe '.reset' do
    it 'requires a user argument' do
      expect { AuthenticationToken.reset }.to raise_error(ArgumentError)
    end

    it 'requires an user' do
      expect { AuthenticationToken.reset(user: nil) }.to raise_error(NoMethodError)
    end

    it 'changes the users authentication token expires at timestamp' do
      user = create(:user)
      AuthenticationToken.reset(user: user)

      expect(user.authentication_token).to be_a String
      expect(user.authentication_token_expires_at).
        to be_within(1).of(token_expiration_date)
      expect(user.authentication_token_expires_at).to be_a Time
    end
  end

  def token_expiration_date
    ENV.fetch('TOKEN_DURATION_DAYS').to_i.days.from_now
  end
end
