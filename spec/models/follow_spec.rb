require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  describe "フォロー機能を検証する場合" do
    before do
      @follow = Follow.create(following_id: user.id, followed_by_id: other_user.id)
    end

    it "機能が有効であること" do
      expect(@follow).to be_valid
    end

    it "following_idがからであれば無効であること" do
      @follow.following_id = nil
      expect(@follow.errors[:following_id]).to include("を入力してください")
    end

    it "followed_by_idがからであれば無効であること" do
      @follow.followed_by_id = nil
      @follow.valid?
      expect(@follow.errors[:followed_by_id]).to include("を入力してください")
    end
  end
end