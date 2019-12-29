module AttendancesHelper
  
  def attendance_state_started(attendance)
    # 受け取ったAttendanceオブジェが当日と一致するか評価.
    if Date.current == attendance.worked_on
      return '出勤' if attendance.started_at.nil?
    end
    # 当てはまらなかったらfalse返す
    false
  end
  
  def attendance_state_finished(attendance)
    if Date.current == attendance.worked_on
    return '退勤' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    false
  end
  
  # 出勤時間と退勤時間を受け取り、在社時間を計算して返す。
  def working_times(start, finish)
    format("%.2f", ((finish - start) / 60) / 60.0)
  end
end
