class TwitterAuthenticator
  def initialize(attrs)
    @attrs = attrs
  end

  def self.perform(attrs)
    new(attrs).perform
  end

  def perform
    if valid_twitter_user?
      user = User.find_or_create_by(lookup_params)
      user.update(user_attributes)
      user.reset_token!
      user
    end
  end

  private

  attr_reader :attrs

  def lookup_params
    { twitter_uid: attrs[:twitter_uid] }
  end

  def user_attributes
    { twitter_token: attrs[:twitter_token],
      twitter_secret: attrs[:twitter_secret],
      twitter_uid: attrs[:twitter_uid],
      twitter_user_name: @client.user.name,
      twitter_user_screen_name: @client.user.screen_name,
      twitter_user_image_url: @client.user.profile_image_url }
  end

  def valid_twitter_user?
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_API_SECRET']
      config.access_token        = attrs[:twitter_token]
      config.access_token_secret = attrs[:twitter_secret]
    end
    attrs[:twitter_uid].to_i == @client.user.id
  end
end
