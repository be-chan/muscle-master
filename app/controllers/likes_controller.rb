class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @like = current_user.likes.build(like_params)
    @tweet = @like.tweet
    respond_to :js if @like.save
  end

  def destroy
    @like = Like.find(params[:id])
    @tweet = @like.tweet
    respond_to :js if @like.destroy
  end

  private

  def like_params
    params.permit(:tweet_id)
  end
end
