# frozen_string_literal: true

require "rails_helper"

describe "Postモデルのテスト" do
  it "有効な投稿内容の場合は保存されるか" do
    expect(FactoryBot.build(:post)).to be_valid
  end
end

RSpec.describe "Postモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { post.valid? }

    let!(:post) { build(:post) }
    
    describe "captionカラム" do
      before { post.caption = caption }
      
      context "空欄の場合" do
        let!(:caption) { "" }

        it "失敗する" do
          expect(subject).to eq false
        end
      end
      
      context "200文字の場合" do
        let!(:caption) { Faker::Lorem.characters(number: 200) }

        it "成功する" do
          expect(subject).to eq true
        end
      end
      
      context "201文字の場合" do
        let!(:caption) { Faker::Lorem.characters(number: 201) }

        it "失敗する" do
          expect(subject).to eq false
        end
      end
    end
  end
  
  describe "アソシエーションのテスト" do
    describe "Userモデルとの関係" do
      it "N:1となっている", spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end