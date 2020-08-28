require 'rails_helper'

RSpec.describe User, type: :model do
  describe "ユーザー登録できる場合" do
    it "アカウントID、アカウント名、メールアドレス、パスワードがあれば有効であること" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
  end

  describe "アカウントIDを検証する場合" do
    it "アカウントIDがなければ無効であること" do
      user = FactoryBot.build(:user, account_id: nil)
      user.valid?
      expect(user.errors[:account_id]).to include("が入力されていません。")
    end
  end

  describe "アカウント名を検証する場合" do
    it "アカウント名がなければ無効であること" do
      user = FactoryBot.build(:user, account_name: nil)
      user.valid?
      expect(user.errors[:account_name]).to include("が入力されていません。")
    end
  end

  describe "メールアドレスを検証する場合" do
    it "メールアドレスがなければ無効であること" do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("が入力されていません。")
    end

    it "メールアドレスが重複していれば無効であること" do
      FactoryBot.create(:user, email: "test1@example.com")
      user = FactoryBot.build(:user, email: "test1@example.com")
      user.valid?
      expect(user.errors[:email]).to include("は既に使用されています。")
    end
  end

  describe "パスワードを検証する場合" do
    it "パスワードがなければ無効であること" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("が入力されていません。")
    end

    it "パスワードが6字以下で無効であること" do
      user = FactoryBot.build(:user, password: "a" * 5, password_confirmation: "a" * 5)
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
    end

    it "パスワードとパスワード（確認）が不一致の時無効であること" do
      user = FactoryBot.build(:user, password: "a" * 6, password_confirmation: "b" * 6)
      user.valid?
      expect(user.errors[:password_confirmation]).to include("がパスワードと一致していません。")
    end
  end
end
