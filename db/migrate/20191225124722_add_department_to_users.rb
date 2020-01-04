class AddDepartmentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :department, :string
    add_column :users, :user_employee_number, :string
    add_column :users, :user_uid, :string
  end
end
