module ExternalRequests
  def stub_twitter_application_authorization_request
    stub_request(:post, /.*api.twitter.com\/oauth2\/token\z/).
      to_return(:status => 200, :body => "", :headers => {})
  end

  def stub_twitter_verify_new_user_credentials
    stub_request(:get, 'https://api.twitter.com/1.1/account/verify_credentials.json').
      with(:headers => {'Accept'=>'application/json', 'User-Agent'=>'TwitterRubyGem/5.16.0'}).
      to_return(:status => 200, :body => response_verify_new_user_credentials, :headers => {})
  end

  def stub_twitter_verify_invalid_user_credentials
    stub_request(:get, 'https://api.twitter.com/1.1/account/verify_credentials.json').
      with(:headers => {'Accept'=>'application/json', 'User-Agent'=>'TwitterRubyGem/5.16.0'}).
      to_return(:status => 400, :body => '', :headers => {})
  end

  def stub_twitter_verify_existing_user_credentials(user)
    stub_request(:get, 'https://api.twitter.com/1.1/account/verify_credentials.json').
      with(:headers => {'Accept'=>'application/json', 'User-Agent'=>'TwitterRubyGem/5.16.0'}).
      to_return(:status => 200, :body => response_verify_existing_user_credentials(user), :headers => {})
  end

  def response_verify_new_user_credentials
    { id: 123456,
      name: 'John Smith',
      screen_name: 'jsmith',
      profile_image_url: 'http://image.com/image1.tiff' }.to_json
  end

  def response_verify_existing_user_credentials(user)
    { id: user.twitter_uid.to_i,
      name: user.twitter_user_name,
      screen_name: user.twitter_user_screen_name,
      profile_image_url: user.twitter_user_image_url }.to_json
  end
end
