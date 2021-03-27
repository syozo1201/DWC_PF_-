class PostsController < ApplicationController

  def index
    @posts = Post.page(params[:page]).page(params[:page]).per(5).order(created_at: :desc)
    #@posts = Post.joins(:user).select("posts.*, users.*").where('title LIKE ? OR post_content LIKE ? OR name LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    #@posts = Kaminari.paginate_array(@posts).page(params[:page]).per(5).order(created_at: :desc)
  end

  def rank
    @posts = Post.find(Favorite.group(:post_id).pluck(:post_id))
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(5)
  end

  def random
    @posts = Post.order("RANDOM()").limit(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      @posts = Post.all
      redirect_to posts_path
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :post_content, :post_image)
  end
end
