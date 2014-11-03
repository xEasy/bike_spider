class FavoritiesController < ApplicationController
  def index
    @favorities = Favority.order(c_at: :desc).page(params[:page]).includes(:post)
  end

  def create
    if Favority.create(post: Post.find(params[:p_id]))
      render json: { success: true }
    else
      render json: { success: false }, status: :failure
    end
  end

  def destroy
    if Favority.where(post_id: params[:id]).first.destroy
      render json: { success: true }
    else
      render json: { success: false }, status: :failure
    end
  end
end
