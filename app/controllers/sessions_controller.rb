class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
     flash.now[:danger] = '認証に失敗しました。'  
     render :new
    end
  end
  
  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
  def update
    if params[:no] == "1"
      user = User.find(1)
      if user
        log_in user
        flash[:success] = '管理者でログインしました。'
        redirect_back_or user
      else
       flash.now[:danger] = '認証に失敗しました。'  
       render :new
      end
    end
  
    if params[:no] == "2"
      user = User.find(2)
      if user
        log_in user
        flash[:success] = '上長Aでログインしました。'
        redirect_back_or user
      else
       flash.now[:danger] = '認証に失敗しました。'  
       render :new
      end
    end
  
    if params[:no] == "3"
      user = User.find(3)
      if user
        log_in user
        flash[:success] = '上長Bでログインしました。'
        redirect_back_or user
      else
       flash.now[:danger] = '認証に失敗しました。'  
       render :new
      end
    end
  
    if params[:no] == "4"
      user = User.find(4)
      if user
        log_in user
        flash[:success] = '一般Aでログインしました。'
        redirect_back_or user
      else
       flash.now[:danger] = '認証に失敗しました。'  
       render :new
      end
    end
  
    if params[:no] == "5"
      user = User.find(5)
      if user
        log_in user
        flash[:success] = '一般Bでログインしました。'
        redirect_back_or user
      else
       flash.now[:danger] = '認証に失敗しました。'  
       render :new
      end
    end
  end
end
