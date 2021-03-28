class UsersController < ApplicationController
  def index
    @users = User.order("created_at DESC").page(params[:page]).per(15)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order("created_at DESC").page(params[:page]).per(5)
    #ユーザーに紐ずくいいね数
    @user_posts = @user.posts
    # 変数を定義し、0を代入。
    @favorites_count = 0
    # countメソッドを使い、１つの投稿に結びつくイイねを予め定義しておいた@favorites_countに足していく。
    @user_posts.each do |post|
      @favorites_count += post.favorites.count
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
        redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image)
  end
end
