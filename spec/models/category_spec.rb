# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categoryモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { category.valid? }

    context 'nameカラム' do
      it '空欄でないこと', spec_category: "バリデーションとメッセージ表示" do
        category.name = ''
        is_expected.to eq false
      end
      it '1文字以上であること: 1文字は〇', spec_category: "バリデーションとメッセージ表示" do
        category.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇', spec_category: "バリデーションとメッセージ表示" do
        category.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×', spec_category: "バリデーションとメッセージ表示" do
        category.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Animalモデルとの関係' do
      it '1:Nとなっている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(Category.reflect_on_association(:animals).macro).to eq :has_many
      end
    end
  end
end