class ListOfAttendeesController < ApplicationController
  
  def index
    @users = User.all.includes(:attendances)
  end
end
