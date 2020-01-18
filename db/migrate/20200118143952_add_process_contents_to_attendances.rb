class AddProcessContentsToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :process_contents, :string
  end
end
