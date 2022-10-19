class CommentsController < ApplicationController
  before_action :require_user_login, only: [:new]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save

      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @comment = Comment.new
  end

  def index
    @comment = Comment.all
  end

  def require_user_login
    if current_user.nil?
      flash[:notice] = "YOU MUST BE LOGGED IN"
      redirect_to login_path
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:bloob)
  end

end

