# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
# Indexes
#
#  index_groups_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'バリデーション' do
    context '正常なパラメータの場合' do
      it 'groupは有効' do
        expect(build(:group)).to be_valid
      end
    end

    context '異常なパラメータの場合' do
      it 'ownerとしてuserと関連がない時、groupは無効' do
        expect(build(:group, owner: nil)).to be_invalid
      end

      it 'nameがnilの時、groupは無効' do
        expect(build(:group, name: nil)).to be_invalid
      end

      it 'nameが空文字の時、groupは無効' do
        expect(build(:group, name: '')).to be_invalid
      end
    end
  end

  describe '#member?' do
    let(:group) { create(:group) }
    let(:user) { create(:user) }

    it 'groupにuserが所属している時、trueを返す' do
      create(:group_user, group:, user:)
      expect(group.member?(user)).to be true
    end

    it 'groupにuserが所属していない時、falseを返す' do
      expect(group.member?(user)).to be false
    end
  end

  describe '#owner?' do
    let(:group) { create(:group) }
    let(:user) { create(:user) }

    it 'groupのownerがuserの時、trueを返す' do
      group.owner = user
      expect(group.owner?(user)).to be true
    end

    it 'groupのownerがuserでない時、falseを返す' do
      expect(group.owner?(user)).to be false
    end
  end

  describe '#number_of_members' do
    it 'グループに参加しているユーザー数が4人の時を4を返す' do
      # グループを作成した地点でオーナーは参加者に含まれる
      group = create(:group)
      create_list(:group_user, 3, group:)
      expect(group.number_of_members).to eq 4
    end
  end
end
