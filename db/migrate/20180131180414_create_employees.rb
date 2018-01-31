class CreateEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.string :key
      t.string :name
      t.string :title
      t.references :org_unit, foreign_key: true

      t.timestamps
    end
  end
end
