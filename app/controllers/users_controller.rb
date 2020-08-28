class UsersController < ApplicationController
  before_action :authenticate_user!, only: :show
  before_action :set_user, only: [:show, :follow]

  def show
  end

  def follow
    if user_signed_in? && @user.id != current_user.id && Follow.find_by(following_id: @user.id).nil?
      Follow.create(following_id: @user.id, followed_by_id: current_user.id)
      @follow = "follow"
    elsif user_signed_in? && @user.id != current_user.id && Follow.find_by(following_id: @user.id) != nil
      Follow.find_by(following_id: @user.id, followed_by_id: current_user.id).destroy
      @follow = "remove"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
