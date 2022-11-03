class LikesController < ApplicationController

  before_action :require_user_login
  before_action :find_blurb
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "Something"
    else
      @blurb.likes.create(user_id: current_user.id)
    end
    redirect_to root_path
  end

  def destroy
    if !already_liked?
      flash[:notice] = "Something"
    else
      @like.destroy
    end
    redirect_to root_path
  end

  def require_user_login
    if current_user.nil?
      flash[:notice] = "YOU MUST BE LOGGED IN"
      redirect_to login_path
    end
  end

  private

  def find_blurb
    @blurb = Blurb.find_by(id: params[:blurb_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, blurb_id:
    params[:blurb_id]).exists?
  end

  def find_like
    @like = @blurb.likes.find(params[:id])
  end
end
