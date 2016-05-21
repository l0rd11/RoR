class CreateUserTwitters < ActiveRecord::Migration
  def change
    create_table :user_twitters do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :token
      t.string :secret
      t.string :profile_image

      t.timestamps null: false
    end
  end
end
