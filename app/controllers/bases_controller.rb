class BasesController < ApplicationController
  before_action :set_base, only: %i(destroy)
  
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
      redirect_to bases_url
    else
      render :new
    end
  end
  
  def destroy
    @base.destroy
    flash[:success] = "#{@base.base_name}のデータを削除しました。"
    redirect_to bases_url
  end
  
  private
    
    def base_params
      params.require(:base).permit(:base_number, :base_name, :attendance_type)
    end
    
    def set_base
      @base = Base.find(params[:id])
    end
end