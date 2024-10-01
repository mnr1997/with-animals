# frozen_string_literal: true

require "rails_helper"

describe "ユーザーログイン後のテスト" do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let!(:other_book) { create(:post, user: other_user) }
  
  before do
    visit new_user_session_path
    fill_in "user[email]", with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end
  
  describe "ヘッダーのテスト" do

    context "表示内容の確認" do
      it "ヘッダーロゴが表示される: 左上から1番目のリンクが「with Animals」である" do
        home_link = find_all("a")[0].text
        expect(home_link).to match(/with Animals/)
      end

      it "新規登録リンクが表示される: 左上から2番目のリンクが「新規投稿」である" do
        home_link = find_all("a")[1].text
        expect(home_link).to match(/新規投稿/)
      end

      it "ログインリンクが表示される: 左上から3番目のリンクが「ログアウト」である" do
        home_link = find_all("a")[2].text
        expect(home_link).to match(/ログアウト/)
      end
      
      it "ログインリンクが表示される: 左上から4番目のリンクがユーザープロフィール、ユーザー名である" do
        home_link = find_all("a")[3].text
        expect(home_link).to match(user.name)
      end
    end

    context "リンク内容の確認" do
      subject { current_path }

      it "ヘッダーロゴを押すと、投稿一覧画面に遷移する" do
        home_link = find_all("a")[0].text
        home_link.gsub!(/\n/, "")
        click_link home_link
        is_expected.to eq "/posts"
      end
      
      it "新規投稿を押すと、新規投稿画面に遷移する" do
        home_link = find_all("a")[1].text
        home_link.gsub!(/\n/, "")
        click_link "新規投稿"
        is_expected.to eq "/posts/new"
      end
      
      it "ログアウトを押すと、ホーム画面に遷移する" do
        home_link = find_all("a")[2].text
        home_link.gsub!(/\n/, "")
        click_link "ログアウト"
        is_expected.to eq "/"
      end
      
      it "プロフィール画像、ユーザー名を押すと、ユーザー詳細画面に遷移する" do
        home_link = find_all("a")[2].text
        home_link.gsub!(/\n/, "")
        click_link user.name, match: :first
        is_expected.to eq "/users/" + user.id.to_s
      end
    end
  end
end