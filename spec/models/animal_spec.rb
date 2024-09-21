# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Animalモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { animal.valid? }

    let(:user) { create(:user) }
    let!(:animal) { build(:animal, user_id: user.id) }

    context 'nameカラム' do
      it '空欄でないこと', spec_category: "バリデーションとメッセージ表示" do
        animal.name = ''
        is_expected.to eq false
      end
      it '1文字以上であること: 1文字は〇', spec_category: "バリデーションとメッセージ表示" do
        animal.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇', spec_category: "バリデーションとメッセージ表示" do
        animal.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×', spec_category: "バリデーションとメッセージ表示" do
        animal.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(Animal.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Categoryモデルとの関係' do
      it 'N:1となっている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(Animal.reflect_on_association(:category).macro).to eq :belongs_to
      end
    end
  end
end