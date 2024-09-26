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
      
      it "新規登録リンクが表示される: 緑色のボタンの表示が「Sign up」である", spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
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
end