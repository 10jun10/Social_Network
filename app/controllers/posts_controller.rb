class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: :create_like

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

  def create_like
    if user_signed_in? && @post.likes.find_by(user_id: current_user.id).nil?
      Like.create(user_id: current_user.id, post_id: @post.id)
      @like = "like"
    elsif user_signed_in? && @post.likes.find_by(user_id: current_user.id) != nil
      Like.find_by(user_id: current_user.id, post_id: @post.id).destroy
      @like = "unlike"
    end
  end

  private

  def set_params
    params[:post].permit(:tweet).permit(:tweet).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
