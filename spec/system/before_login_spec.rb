# frozen_string_literal: true

require "rails_helper"

describe "ユーザーログイン前のテスト" do
  describe "トップ画面のテスト" do
    before do
      visit root_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/"
      end

      it "ログインリンクが表示される: 青色のボタンの表示が「ユーザーログイン」である" do
        sign_in_link = find_all("a")[3].text
        expect(sign_in_link).to match(/ユーザーログイン/)
      end

      it "ログインリンクの内容が正しい" do
        sign_in_link = find_all("a")[3].text
        expect(page).to have_link sign_in_link, href: new_user_session_path
      end

      it "新規登録リンクが表示される: 緑色のボタンの表示が「新規登録」である" do
        sign_up_link = find_all("a")[4].text
        expect(sign_up_link).to match(/新規登録/)
      end

      it "新規登録リンクの内容が正しい" do
        sign_up_link = find_all("a")[4].text
        expect(page).to have_link sign_up_link, href: new_user_registration_path
      end

      it "ゲストログインリンクが表示される: 青色のボタンの表示が「ゲストログイン（閲覧用）」である" do
        guest_sign_in_link = find_all("a")[5].text
        expect(guest_sign_in_link).to match(/ゲストログイン（閲覧用）/)
      end

      it "ゲストログインリンクの内容が正しい" do
        sign_in_link = find_all("a")[5].text
        expect(page).to have_link sign_in_link, href: users_guest_sign_in_path
      end
    end
  end

  describe "ヘッダーのテスト" do
    before do
      visit root_path
    end

    context "表示内容の確認" do
      it "ヘッダーロゴが表示される: 左上から1番目のリンクが「with Animals」である" do
        home_link = find_all("a")[0].text
        expect(home_link).to match(/with Animals/)
      end

      it "新規登録リンクが表示される: 左上から2番目のリンクが「新規登録」である" do
        home_link = find_all("a")[1].text
        expect(home_link).to match(/新規登録/)
      end

      it "ログインリンクが表示される: 左上から3番目のリンクが「ログイン」である" do
        home_link = find_all("a")[2].text
        expect(home_link).to match(/ログイン/)
      end
    end

    context "リンク内容の確認" do
      subject { current_path }

      it "ヘッダーロゴを押すと、トップ画面に遷移する" do
        home_link = find_all("a")[0].text
        home_link.gsub!(/\n/, "")
        click_link home_link
        is_expected.to eq "/"
      end
      
      it "新規登録を押すと、新規登録画面に遷移する" do
        home_link = find_all("a")[1].text
        home_link.gsub!(/\n/, "")
        click_link "新規登録", match: :first
        is_expected.to eq "/users/sign_up"
      end
      
      it "ログインを押すと、ログイン画面に遷移する" do
        home_link = find_all("a")[2].text
        home_link.gsub!(/\n/, "")
        click_link "ログイン", match: :first
        is_expected.to eq "/users/sign_in"
      end
    end
  end

  describe "ユーザー新規登録のテスト" do
    before do
      visit new_user_registration_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/users/sign_up"
      end

      it "「新規登録」と表示される" do
        expect(page).to have_content "新規登録"
      end

      it "名前フォームが表示される" do
        expect(page).to have_field "user[name]"
      end

      it "メールアドレスフォームが表示される" do
        expect(page).to have_field "user[email]"
      end

      it "パスワードフォームが表示される" do
        expect(page).to have_field "user[password]"
      end
      it "パスワード確認フォームが表示される" do
        expect(page).to have_field "user[password_confirmation]"
      end

      it "登録ボタンが表示される" do
        expect(page).to have_button "登録"
      end
    end

    context "新規登録が成功" do
      before do
        fill_in "user[name]", with: Faker::Lorem.characters(number: 10)
        fill_in "user[email]", with: Faker::Internet.email
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
      end

      it "正しく新規登録される" do
        expect { click_button "登録" }.to change(User.all, :count).by(1)
      end

      it "新規登録後のリダイレクト先が投稿一覧画面になっている" do
        click_button "登録"
        expect(current_path).to eq "/posts"
      end
    end
  end

  describe "ユーザーログインのテスト" do
    let!(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context "表示内容の確認" do
      it "URLが正しい" do
        expect(current_path).to eq "/users/sign_in"
      end

      it "「ユーザーログイン」と表示される" do
        expect(page).to have_content "ユーザーログイン"
      end

      it "メールアドレスフォームが表示される" do
        expect(page).to have_field "user[email]"
      end

      it "パスワードフォームが表示される" do
        expect(page).to have_field "user[password]"
      end

      it "ログインボタンが表示される" do
        expect(page).to have_button "ログイン"
      end
    end

    context "ログイン成功" do
      before do
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
      end

      it "ログイン後のリダイレクト先が投稿一覧画面になっている" do
        click_button "ログイン"
        expect(current_path).to eq "/posts"
      end
    end

    context "ログイン失敗" do
      before do
        fill_in "user[email]", with: ""
        fill_in "user[password]", with: ""
      end

      it "ログインに失敗し、ログイン画面にリダイレクトされる" do
        click_button "ログイン"
        expect(current_path).to eq "/users/sign_in"
      end
    end
  end
end