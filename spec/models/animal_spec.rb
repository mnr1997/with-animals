# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Animalモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { animal.valid? }

    let!(:animal) { build(:animal) }

    describe "nameカラム" do
      before { animal.name = name }

      context "空欄の場合" do
        let!(:name) { "" }

        it "失敗する" do
          expect(subject).to eq false
        end

        it "エラーメッセージが正しい" do
          subject
          expect(animal.errors.full_messages).to contain_exactly("名前を入力してください", "名前は1文字以上で入力してください")
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
    end
  end

  describe "アソシエーションのテスト" do
    describe "Userモデルとの関係" do
      it "N:1となっている", spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(Animal.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    describe "Categoryモデルとの関係" do
      it "N:1となっている", spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(Animal.reflect_on_association(:category).macro).to eq :belongs_to
      end
    end
  end
end