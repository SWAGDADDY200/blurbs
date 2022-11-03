class CommentsController < ApplicationController
  
  before_action :set_blurb
  before_action :require_user_login, only: [:new]

  def create
    @comment = current_user.comments.new(comment_params)
    # @blurb.comments = current_user.comments
    @comment.blurb = @blurb
    if @comment.save
      redirect_to blurb_comments_path	
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @comment = @blurb.comments.new
  end

  def index
    @comment = @blurb.comments
  end

  def destroy
    @blurb = current_user.comments.find(params[:id])
    @blurb.comment.destroy
    flash[:success] = 'Comment was successfully destroyed!'
    redirect_to blurb_comments_path	
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

  def set_blurb
    @blurb = Blurb.find(params[:blurb_id])
  end
end
