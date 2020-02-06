class CreateOvertimes < ActiveRecord::Migration[5.1]
  def change
    create_table :overtimes do |t|
      t.date :overtime_day
      t.datetime :end_time
      t.string :process_contents
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
