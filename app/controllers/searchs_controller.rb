class SearchsController < ApplicationController
  def search
    @posts = Post.joins(:user).where('title LIKE ? OR post_content LIKE ? OR name LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(5)
  end
end
