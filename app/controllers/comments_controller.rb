class CommentsController < ActionController::Base
  def create
    movie = Movie.find(params[:movie_id])

    comment = movie.comments.new(comment_params)
    comment.user = current_user
    comment.save

    redirect_to movie, notice: "Thanks for sharing!"
  end

  def destroy
    comment = Comment.find(params[:id])
    movie = comment.movie

    if comment.can_be_destroyed_by?(current_user)
      comment.destroy
      redirect_to movie, notice: "You can always write another one!"
    else
      redirect_to movie, notice: "Hey, this is not your comment!"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
