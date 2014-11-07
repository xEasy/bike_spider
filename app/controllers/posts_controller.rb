class PostsController < ApplicationController
  def index
    @posts = Post.where(title: /#{ params[:q] }/)
    @posts = @posts.where(from: params[:from]) if params[:from].present?
    @posts = @posts.order(c_at: :desc).page(params[:page])
  end

  def show
  end

  def fetch_all
    if Progress.doing.size > 0
      head 403
    else
      Thread.start do
        progress = Progress.create
        fetch_count = PostSpider.new.fetch_all
        progress.update fetch_count: fetch_count
        progress.done!
      end
      head 200
    end
  end

  def fetch_result
    render json: {
      done: Progress.doing.size == 0,
      fetch_count: Progress.has_done.last.try(:fetch_count),
      last_time: Progress.has_done.last.try(:c_at).strftime('%m/%d %H:%M:%S')
    }
  end
end
