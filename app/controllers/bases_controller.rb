class BasesController < ApplicationController
  def index
    @bases = Base.all
  end
  
  def new
    @base = Base.new
  end
  
  def create
    @base = Base.new(base_params)
    if @base.save
      flash[:success] = "拠点情報を作成しました。"
      redirect_to @base
    else
      flash[:success] = "ユーザー情報を追加/更新しました。"
      render :new
    end
  end
end