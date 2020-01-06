require 'csv'

CSV.generate do |csv|

  column_names = %w(日付 出社時間 退社時間 備考)
  csv << column_names
  @attendances.each do |attendance|
    column_values = [
    
      attendance.worked_on.strftime("%m/%d"),
      
      if attendance.started_at == nil
        attendance.started_at
      else
        attendance.started_at.strftime("%H:%M")
      end,
      
      if attendance.finished_at == nil
        attendance.finished_at
      else
        attendance.finished_at.strftime("%H:%M")
      end,
      
      attendance.note
      
    ]
    csv << column_values  
  end
end