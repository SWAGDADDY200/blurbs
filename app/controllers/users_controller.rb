class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  # before_action :authorize_user, only: [:edit, :update, :destroy]
  def index
    @users = User.all

    @user = current_user

  end

  def show
  end

  def new
    @user = User.new
  end

  
  def edit
    @user = User.find(params[:id])

  end

  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "Blurb was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if current_user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user)
          .permit(:name, :email, :password, :password_confirmation,
                  :image, :banner, :bio, :birthday, :location, :username)
  end
end

# def authorize_user
#   redirect_to(root_page) unless @user == current_user
# end
