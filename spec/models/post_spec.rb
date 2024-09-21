# frozen_string_literal: true

require 'rails_helper'

describe 'Postモデルのテスト' do
  it "有効な投稿内容の場合は保存されるか" do
    expect(FactoryBot.build(:post)).to be_valid
  end
end

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }
    
    context 'captionカラム' do
      it '空欄でないこと', spec_category: "バリデーションとメッセージ表示" do
        post.caption = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 200文字は〇', spec_category: "バリデーションとメッセージ表示" do
        post.caption = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×', spec_category: "バリデーションとメッセージ表示" do
        post.caption = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end