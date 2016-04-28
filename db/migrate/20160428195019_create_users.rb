class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.timestamps null: false

      t.string :twitter_uid
      t.string :twitter_token
      t.string :twitter_secret
      t.string :twitter_user_name
      t.string :twitter_user_screen_name
      t.string :twitter_user_image_url
      t.string :authentication_token
      t.datetime :authentication_token_expires_at
    end
  end
end
