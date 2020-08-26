require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "ユーザー新規登録" do
    before do
      get new_user_registration_path
    end

    it "正常なレスポンスを返すこと" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "ユーザーで登録できること" do
      expect {
        post user_registration_path, params: { user: { account_id: "test",
                                                       account_name: "test",
                                                       email: "test@example.com",
                                                       password: "password",
                                                       password_confirmation: "password" } }
      }.to change(User, :count).by(1)
    end

    it "ユーザー登録できないこと" do
      expect {
        post user_registration_path, params: { user: { account_id: "",
                                                       account_name: "test",
                                                       email: "test@example.com",
                                                       password: "password",
                                                       password_confirmation: "password" } }
      }.not_to change(User, :count)
    end
  end
end
