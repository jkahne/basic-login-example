class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :password_reset_token
      t.datetime :password_reset_set_at
      t.string :role
      t.boolean :active, :boolean, default: true
      t.timestamps
    end
  end
end
