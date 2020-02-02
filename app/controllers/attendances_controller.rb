class AttendancesController < ApplicationController
  protect_from_forgery
  before_action :set_user, only: %i(edit_one_month update_one_month attendances_log edit_over_time update_over_time edit_overtime_notice edit_superior_notice edit_attendance_notice)
  before_action :logged_in_user, only: %i(update edit_one_month edit_over_time)
  before_action :admin_or_correct_user, only: %i(update edit_one_month update_one_month edit_over_time)
  before_action :set_one_month, only: %i(edit_one_month)
  before_action :set_one_day, only: %i(edit_over_time edit_superior_notice edit_attendance_notice edit_overtime_notice)
  
  UPDATE_REEOR_MSG = "勤怠登録に失敗しました。やり直してください。"

  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "おはようございます!"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした。"
      else
        flahs[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
  end
  
  def edit_one_month
  end
  
  def update_one_month
    ActiveRecord::Base.transaction do
      attendances_params.each do |id, item|
        attendance = Attendance.find(id)
        attendance.update_attributes!(item)
      end
    end
    flash[:success] = "1ヶ月分の勤怠情報を更新しました。"
    redirect_to user_url(date: params[:date])
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "無効な入力データがあったため、更新をキャンセルしました。"
    redirect_to attendances_edit_one_month_user_url(date: params[:date])
  end
  
  def attendances_log
    @users = User.all.includes(:attendances)
  end
  
  def edit_over_time
  end
  
  def update_over_time
    ActiveRecord::Base.transaction do
      attendances_params.each do |id, item|
        attendance = Attendance.find(id)
        attendance.update_attributes!(item)
      end
    end
      flash[:success] = "終了予定時間を申請しました。"
      redirect_to user_url(date: params[:day])
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "無効な入力データがあったため、更新をキャンセルしました。"
    redirect_to attendances_edit_over_time_user_url(date: params[:day])
  end
  
  def edit_superior_notice
  end
  
  def edit_attendance_notice
  end
  
  def edit_overtime_notice
    @overtimes = Attendance.where(overtime: true)
  end
  
  private
    # １か月分の勤怠情報を扱う.
    def attendances_params
      params.require(:user).permit(attendances: [:started_at, :finished_at, :note, :end_time, :process_contents])[:attendances]
    end
    
    # beforeフィルター
    
    # 管理権限者、または現在ログインしているユーザーを許可
    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end
    end
end