class CreateSeats < ActiveRecord::Migration[6.0]
  def change
    create_table :seats do |t|
      t.string :name
      t.string :row
      t.string :column
      t.string :status
      t.references :venue_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
