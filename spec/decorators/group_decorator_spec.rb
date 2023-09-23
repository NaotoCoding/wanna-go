require 'rails_helper'

RSpec.describe GroupDecorator do
  describe '#owner_name' do
    it 'グループオーナーの名前を返す' do
      group = create(:group, owner: create(:user, name: 'owner'))
      expect(group.decorate.owner_name).to eq 'owner'
    end
  end

  describe '#user_count' do
    it 'グループに参加しているユーザー数が4人の時を4を返す' do
      # グループを作成した地点でオーナーは参加者に含まれる
      group = create(:group)
      create_list(:group_user, 3, group:)
      expect(group.decorate.user_count).to eq 4
    end
  end
end
