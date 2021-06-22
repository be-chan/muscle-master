class MemosController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :user_memos_find_params, only: [:index, :new, :edit]
  before_action :memos_find_params, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]


  def index
    @memo = Memo.new
    @memos = Memo.where(user_id: @user.id).order("start_time DESC").page(params[:page]).per(3)
    search_memos
  end

  def new 
    @memo = Memo.new
  end

  def create
    @memo = Memo.new(memos_params)
    if @memo.save
      redirect_to user_memos_path(current_user.id)
      flash[:notice] = "トレーニング内容を新しくメモしました"
    else
      render :new
    end
  end

  def edit
   
  end

  def update
    if @memo.update(memos_params)
      redirect_to user_memos_path(current_user.id)
      flash[:notice] = "トレーニング内容を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @memo.destroy
    redirect_to user_memos_path(current_user.id)
  end

  private
    def user_memos_find_params 
      @user = User.find(params[:user_id])
    end

    def memos_find_params
      @memo = Memo.find(params[:id])
    end

    def memos_params
      params.require(:memo).permit(:start_time, :training_content, :weight, :training_time, :set_count_id).merge(user_id: current_user.id)
    end

    def correct_user
      redirect_to user_memos_path(current_user.id) unless current_user.id == @memo.user.id
    end

    def search_memos
      @q = Memo.ransack(params[:q])
      @memos = @q.result(distinct: true).where(user_id: @user.id).order("start_time DESC").page(params[:page]).per(3)
    end

end
