class UsersController < ApplicationController
  def salty
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(params[:twitch_id])
  end

  def update
    redirect_to salty_path
  end
end
