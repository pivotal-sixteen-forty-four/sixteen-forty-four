class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :floor
      t.string :suite
      t.string :description
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
