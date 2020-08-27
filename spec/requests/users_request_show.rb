require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    @user = FactoryBot.create(:user)
  end

  describe "プロフィール" do
    context "ログイン済みのユーザー" do
      it "正常なレスポンスを返すこと" do
        sign_in @user
        get user_path(@user)
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end  
    
    context "ログインしていないユーザー" do
      it "302レスポンスを返すこと" do
        get user_path(@user)
        expect(response).to have_http_status(302)
      end

      it "ログイン画面へリダイレクトすること" do
        get user_path(@user)
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
