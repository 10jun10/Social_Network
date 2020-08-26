require 'rails_helper'

RSpec.describe Post, type: :model do
  it "tweetの中身が空でないこと" do
    post = FactoryBot.build(:post, tweet: nil)
    post.valid?
    expect(post.errors[:tweet]).to include("が入力されていません。")
  end
end
