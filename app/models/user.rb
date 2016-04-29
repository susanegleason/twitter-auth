class User < ActiveRecord::Base
  validates :twitter_uid, presence: true
  validates :twitter_uid, uniqueness: true, allow_nil: true
  validates :twitter_token, uniqueness: true, allow_nil: true
  validates :authentication_token, uniqueness: true, allow_nil: true

  def reset_token!
    loop do
      if AuthenticationToken.reset(user: self)
        break
      end
    end
  end
end
