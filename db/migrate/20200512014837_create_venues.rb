class CreateVenues < ActiveRecord::Migration[6.0]
  def change
    create_table :venues do |t|
      t.integer :rows
      t.integer :columns
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
