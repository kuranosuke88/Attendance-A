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
      flash.now[:success] = "拠点情報を作成しました。"
      redirect_to new
    else
      render :new
    end
  end
  
  private
    
    def base_params
      params.require(:base).permit(:base_number, :base_name, :attendance_type)
    end
end