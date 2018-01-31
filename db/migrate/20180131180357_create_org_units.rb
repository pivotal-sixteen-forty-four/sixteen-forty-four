class CreateOrgUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :org_units do |t|
      t.string :key
      t.string :name
      t.references :company

      t.timestamps
    end
  end
end
