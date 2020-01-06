require 'csv'

CSV.generate do |csv|
  column_names = %w(id name email department user_employee_number user_uid)
  csv << column_names
  @users.each do |user|
    column_values = [
    
      user.id,
      user.name,
      user.email,
      user.department,
      user.user_employee_number,
      user.user_uid
    ]
    csv << column_values  
  end
end