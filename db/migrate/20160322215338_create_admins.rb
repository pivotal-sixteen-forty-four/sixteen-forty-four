class CreateAdmins < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :email
      t.string :uid
      t.string :provider
      t.string :token
      t.string :name

      t.timestamps
    end
  end
end
