class HomesController < ApplicationController
  def top
    if ActiveRecord::Base.connection_config[:adapter] == 'sqlite3'  #ローカル。DBで判断
    @posts = Post.order("RANDOM()").limit(3)
    else
    @posts = Post.order("RAND()").limit(3)
    end
  end

  def about
  end
end
