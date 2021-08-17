class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_find_params

  def show
    
  end

  def following
    # @userがフォローしているユーザー
    @users = @user.following
    render 'show_follow'
  end

  def followers
    # @userをフォローしているユーザー
    @users = @user.followers
    render 'show_follower'
  end

  private 

  def user_find_params
    @user = User.find(params[:id])
  end
end
