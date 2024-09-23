# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Categoryモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { category.valid? }
    
    let!(:category) { build(:category) }

    describe "nameカラム" do
      before { category.name = name }
      
      context "空欄の場合" do
        let!(:name) { "" }

        it "失敗する" do
          expect(subject).to eq false
        end

        it "エラーメッセージが正しい" do
          subject
          expect(category.errors.full_messages).to contain_exactly("カテゴリー名は1文字以上で入力してください", "カテゴリー名を入力してください")
        end
      end
      
      context "1文字の場合" do
        let!(:name) { Faker::Lorem.characters(number: 1) }

        it "成功する" do
          is_expected.to eq true
        end
      end
      
      context "20文字の場合" do
        let!(:name) { Faker::Lorem.characters(number: 20) }

        it "成功する" do
          is_expected.to eq true
        end
      end
      
      context "21文字の場合" do
        let!(:name) { Faker::Lorem.characters(number: 21) }

        it "失敗する" do
          is_expected.to eq false
        end
        
        it "エラーメッセージが正しい" do
          subject
          expect(category.errors.full_messages).to contain_exactly("カテゴリー名は20文字以内で入力してください")
        end
      end
    end
  end

  describe "アソシエーションのテスト" do
    describe "Animalモデルとの関係" do
      it "1:Nとなっている", spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(Category.reflect_on_association(:animals).macro).to eq :has_many
      end
    end
  end
end