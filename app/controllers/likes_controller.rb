class LikesController < ApplicationController
  before_action :authenticate_user!
  def create 
    @like = current_user.likes.build(like_params)
    @tweet = @like.tweet
    if @like.save
      respond_to :js
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @tweet = @like.tweet
    if @like.destroy
      respond_to :js
    end
  end

  private 
  def like_params
    params.permit(:tweet_id)
  end
end
