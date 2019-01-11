class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.references :account, foreign_key: true, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :auth_token
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
      t.timestamps
    end
  end
end
