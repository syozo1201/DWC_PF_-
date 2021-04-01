class PostsController < ApplicationController

  def index
    @posts = Post.page(params[:page]).page(params[:page]).per(5).order(created_at: :desc)
  end

  def rank
    @posts = Post.find(Favorite.group(:post_id).pluck(:post_id))
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(5)
  end

  def random
    if ActiveRecord::Base.connection_config[:adapter] == 'sqlite3'  #ローカル。DBで判断
    @posts = Post.order("RANDOM()").limit(5)
    else
    @posts = Post.order("RAND()").limit(5)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.score = Language.get_data(post_params[:post_content])
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user != current_user
      redirect_to post_path(@post.id)
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.user == current_user
      post.destroy
      flash[:notice] = "投稿が削除されました。"
    else
      flash[:alert] = "投稿の削除に失敗しました。"
    end
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :post_content, :post_image)
  end
end
