require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { FactoryBot.create(:user) }

  describe "プロフィール" do
    context "ログイン済みのユーザーの場合" do
      it "正常なレスポンスを返すこと" do
        sign_in user
        get user_path(user)
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    context "ログインしていないユーザーの場合" do
      it "302レスポンスを返すこと" do
        get user_path(user)
        expect(response).to have_http_status(302)
      end

      it "ログイン画面へリダイレクトすること" do
        get user_path(user)
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
