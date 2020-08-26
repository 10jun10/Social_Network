require 'rails_helper'

RSpec.describe User, type: :model do
  it "アカウントID、アカウント名、メールアドレス、パスワードがあれば有効であること" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "アカウントIDがなければ無効であること" do
    user = FactoryBot.build(:user, account_id: nil)
    user.valid?
    expect(user.errors[:account_id]).to include("が入力されていません。")
  end

  it "アカウント名がなければ無効であること" do
    user = FactoryBot.build(:user, account_name: nil)
    user.valid?
    expect(user.errors[:account_name]).to include("が入力されていません。")
  end

  it "メールアドレスがなければ無効であること" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("が入力されていません。")
  end

  it "メールアドレスが重複していれば無効であること" do
    FactoryBot.create(:user, email: "test@example.com")
    user = FactoryBot.build(:user)
    user.valid?
    expect(user.errors[:email]).to include("は既に使用されています。")
  end

  it "パスワードがなければ無効であること" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("が入力されていません。")
  end

  it "パスワードが6字以下で無効であること" do
    user = FactoryBot.build(:user, password: "a" * 5,password_confirmation: "a" * 5)
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
  end
  
  it "パスワードとパスワード（確認）が不一致の時無効であること" do
    user = FactoryBot.build(:user, password: "a" * 6,password_confirmation: "b" * 6)
    user.valid?
    expect(user.errors[:password_confirmation]).to include("がパスワードと一致していません。")
  end

end
