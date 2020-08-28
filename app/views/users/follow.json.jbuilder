json.follow @follow
json.follower Follow.where(following_id: @user.id).count

@follower = []
Follow.where(following_id: @user.id).each do |follow|
  @follower << { name: User.find(follow.followed_by_id).account_name, link: user_path(follow.followed_by_id) }
end
json.followers @follower
