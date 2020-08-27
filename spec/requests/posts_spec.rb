require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /index" do
    it "正常なレスポンスを返すこと" do
      get root_path
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /new" do
    context "ログイン済みのユーザー" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "正常なレスポンスを返すこと" do
        sign_in @user
        get new_post_path
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    context "ログインしていない" do
      it "302レスポンスを返すこと" do
        get new_post_path
        expect(response).to have_http_status(302)
      end


    end
  end

  describe "POST /create" do
    context "ログイン済みのユーザー" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "投稿を追加できること" do
        post_params = FactoryBot.attributes_for(:post)
        sign_in @user
        expect {
          post posts_path, params: { post: post_params }
        }.to change(@user.posts, :count).by(1)
      end
    end

    context "ログインしていない" do
      it "302レスポンスを返すこと" do
        post_params = FactoryBot.attributes_for(:post)
        post posts_path, params: { post: post_params }
        expect(response).to have_http_status(302)
      end

      it "ログイン画面へリダイレクトすること" do
        post_params = FactoryBot.attributes_for(:post)
        post posts_path, params: { post: post_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
