class PostsController < ApplicationController
  def index
    @posts = Post.where(title: /#{ params[:q] }/)
    @posts = @posts.where(from: params[:from]) if params[:from].present?
    @posts = @posts.order(c_at: :desc).page(params[:page])
  end

  def show
  end
end
