class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(set_params)
    if @post.valid?
      @post.save
      redirect_to root_path
    else
      redirect_to new_post_path
    end
  end

  private

  def set_params
    params[:post].permit(:tweet).permit(:tweet).merge(user_id: current_user.id)
  end
end
