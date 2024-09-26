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
end