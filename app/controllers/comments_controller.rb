class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @tweet = @comment.tweet
    if @comment.save
      redirect_to tweet_path(@tweet.id)
    else
      render :show
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @tweet = @comment.tweet
    if @comment.destroy
      redirect_to tweet_path(@tweet.id)
    else
      flash[:alert] = 'コメントの削除に失敗しました'
    end
  end

  private

  def comment_params
    params.required(:comment).permit(:user_id, :tweet_id, :body)
  end
end
