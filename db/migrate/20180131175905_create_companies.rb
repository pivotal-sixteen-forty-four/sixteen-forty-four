class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :key
      t.string :title
      t.string :floor
      t.string :suite
      t.string :instructions
      t.string :phone
      t.string :website

      t.timestamps
    end
  end
end
