class BlurbsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_author, only: [:edit, :update, :destroy]
  before_action :require_user_login, except: [:show, :index]

  def create
    @blurb = current_user.blurbs.new(blurb_params)
    if @blurb.save
      redirect_to blurbs_path, info: "Post was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @blurb = current_user.blurbs.new
  end

  def index
    @blurbs = Blurb.all

    if params[:tag]
      @articles = Article.tagged_with(params[:tag])
    else
      @articles = Article.all
    end
  end

  # def show
  #   @posts = Post.find(params[:id])
  # end
  def update
    @blurb = current_user.blurbs.find(params[:id])

    if @blurb.update(blurb_params)
      redirect_to @blurb, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @blurb = current_user.blurbs.find(params[:id])
    @blurb.destroy
    flash[:success] = 'Post was successfully destroyed!'
    redirect_to root_path
  end

  def edit
    @blurb = current_user.blurbs.find(params[:id])
  end

  def require_user_login
    if current_user.nil?
      flash[:notice] = 'YOU MUST BE LOGGED IN'
      redirect_to login_path
    end
  end

  private

  def set_post
    @blurb = Blurb.find(params[:id])
  end

  def require_author
    redirect_to(root_path) unless @blurb.user == current_user
  end

  def blurb_params
    params.require(:blurb).permit(:name, :body, :picture)
  end

end
