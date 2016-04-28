require 'rails_helper'

describe User do
  let!(:user) { create(:user) }

  describe 'validations' do
    it { should validate_presence_of :twitter_uid }
    it { should validate_uniqueness_of(:twitter_uid).allow_nil }
    it { should validate_uniqueness_of(:twitter_token).allow_nil }
    it { should validate_uniqueness_of(:authentication_token).allow_nil }
  end
end
