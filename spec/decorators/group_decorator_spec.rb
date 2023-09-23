require 'rails_helper'

RSpec.describe GroupDecorator do
  describe '#owner_name' do
    it 'グループオーナーの名前を返す' do
      group = create(:group, owner: create(:user, name: 'owner'))
      expect(group.decorate.owner_name).to eq 'owner'
    end
  end

  describe '#user_count' do
    it 'グループに参加しているユーザー数が3人の時を3返す' do
      group = create(:group)
      create_list(:group_user, 3, group: group)
      expect(group.decorate.user_count).to eq 3
    end
  end
end
