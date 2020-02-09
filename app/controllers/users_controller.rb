class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update destroy edit_basic_info update_basic_info)
  before_action :logged_in_user, only: %i(index show edit update destroy edit_basic_info update_basic_info)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy edit_basic_info update_basic_info)
  before_action :set_one_month, only: %i(show)
  
  def view
  end
  
  def index
    @users = User.paginate(page: params[:page])
    
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string, filename: "ユーザー情報.csv", type: :csv
      end
    end
  end
  
  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
    @overtimes_sum = Attendance.where(overtime: true).count
    
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string, filename: "#{@first_day.strftime("%y年%m月")}勤怠情報.csv", type: :csv
      end
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "新規作成に成功しました。"
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
  end
  
  def edit_info
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  def edit_basic_info
  end
  
  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end
  
  def import
    if params[:file].blank?
      flash[:danger] = "インポートするCSVファイルを選択してください。"
      redirect_to users_url
    else
      User.import(params[:file])
      flash[:success] = "ユーザー情報を追加/更新しました。"
      redirect_to users_url
    end
  end
  
  private
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def basic_info_params
      params.require(:user).permit(:department, :basic_time, :work_time, :work_finish_time, :user_employee_number, :user_uid)
    end
end