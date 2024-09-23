# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Userモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { user.valid? }

    let!(:other_user) { build(:user) }
    let!(:user) { build(:user) }

    describe "nameカラム" do
      before { user.name = name }
      
      context "空欄の場合" do
        let!(:name) { "" }

        it "失敗する" do
          expect(subject).to eq false
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
      end
      
      context "一意性がある場合" do
        let!(:name) { other_user.name }
        
        it "成功する" do
          is_expected.to eq true
        end
      end
    end

    describe "introductionカラム" do
      before { user.introduction = introduction }
      
      context "50文字の場合" do
        let!(:introduction) { Faker::Lorem.characters(number: 50) }

        it "成功する" do
          is_expected.to eq true
        end
      end
      
      context "51文字の場合" do
        let!(:introduction) { Faker::Lorem.characters(number: 51) }

        it "失敗する" do
          is_expected.to eq false
        end
      end
    end
  end

  describe "アソシエーションのテスト" do
    describe "Postモデルとの関係" do
      it "1:Nとなっている", spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
    
    describe "Animalモデルとの関係" do
      it "1:Nとなっている", spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(User.reflect_on_association(:animals).macro).to eq :has_many
      end
    end
    
    describe "Favoriteモデルとの関係" do
      it "1:Nとなっている", spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    
    describe "Commentモデルとの関係" do
      it "1:Nとなっている", spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
  end
end