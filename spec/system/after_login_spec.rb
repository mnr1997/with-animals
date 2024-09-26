# frozen_string_literal: true

require "rails_helper"

describe "ユーザーログイン前のテスト" do
  let!(:post) { FactoryBot.build(:post) }
  
  describe "一覧画面のテスト" do
    before do 
      visit posts_path
    end
    
    context "URLが正しい" do
      it "URLが正しい" do
        expect(current_path).to eq "/books"
      end
    end
  end
end