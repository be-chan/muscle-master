class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :tweet_memo_params, only: [:new, :create, :destroy]
  before_action :tweet_find_params, only: [:show, :destroy]

  def index
    @tweets = Tweet.includes(:user).order('created_at DESC').page(params[:page]).per(3)
  end

  def show
    
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to tweets_path
    else
      render :new
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body).merge(user_id: @memo.user.id, memo_id: @memo.id)
  end

  def tweet_memo_params
    @memo = Memo.find(params[:memo_id])
  end

  def tweet_find_params
    @tweet = Tweet.find(params[:id])
  end
end
