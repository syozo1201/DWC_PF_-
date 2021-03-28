class HomesController < ApplicationController
  def top
    @posts = Post.order("RANDOM()").limit(3)
  end

  def about
  end
end
