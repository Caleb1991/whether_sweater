class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :password_confirmation
      t.string :api_key, default: nil
      t.timestamps
    end
  end
end
