require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "ログイン" do
    before do
      @user = FactoryBot.create(:user)
    end

    it "正常なレスポンスを返すこと" do
      get new_user_session_path
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "有効なユーザーでログイン・ログアウト" do
      get new_user_session_path
      post user_session_path, params: { session: { email: @user.email,
                                                   password: @user.password } }
    end
  end
end
