class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionHelper
  
  $days_of_the_week = %w{日 月 火 水 木 金 土}
  
  # berofeフィルター
    
    # paramsハッシュからユーザーid取得
    
    def set_user
      @user = User.find(params[:id])
    end
    
    # ログインユーザーか判定
    
    def logged_in_user
      unless logged_in?
       store_location
       flash[:danger] = "ログインしてください。"
       redirect_to login_url
      end
    end
    
    # アクセスしたユーザーが現在ログインしているユーザーか確認。
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # システム管理権限所有か判定.
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
    
    # 上長権限者か判定
    def superior_user
      redirect_to root_url unless current_user.superior?
    end
  
  # ページ出力前に1ヶ月分のデータの存在を確認・セットします。
  def set_one_month 
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day] # 対象の月の日数を代入します。
    # ユーザーに紐付く一ヶ月分のレコードを検索し取得します。
    @attendances = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)

    unless one_month.count == @attendances.count # それぞれの件数（日数）が一致するか評価します。
      ActiveRecord::Base.transaction do # トランザクションを開始します。
        # 繰り返し処理により、1ヶ月分の勤怠データを生成します。
        one_month.each { |day| @user.attendances.create!(worked_on: day) }
      end
      @attendances = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)
    end

  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
    flash[:danger] = "ページ情報の取得に失敗しました、再アクセスしてください。"
    redirect_to root_url
  end
  
  # ページ出力前に1日分のデータの存在を確認・セットします。
  def set_one_day
    @first_day = params[:day].nil? ?
    Date.current.beginning_of_day : params[:day].to_date
    one_day = [@first_day]
    
    @attendances = @user.attendances.where(worked_on: @first_day)
    unless one_day.count == @attendances.count
      ActiveRecord::Base.transaction do
        one_day.each { |day| @user.attendances.create!(worked_on: day) }
      end
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "ページ情報の取得に失敗しました。再アクセスしてください。"
    redirect_to root_url
  end
  
end