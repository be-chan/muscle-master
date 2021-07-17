class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :tweet_memo_params, only: [:new, :create]

  def index 
    @tweets = Tweet.includes(:user).order('created_at DESC').page(params[:page]).per(3)
  end

  def show
    @tweet = Tweet.find(params[:id])
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

  private
   def tweet_params
    params.require(:tweet).permit(:body).merge(user_id: @memo.user.id, memo_id: @memo.id)
   end
   def tweet_memo_params
     @memo = Memo.find(params[:memo_id])
   end
end
