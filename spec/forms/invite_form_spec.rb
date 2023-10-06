require 'rails_helper'

RSpec.describe 'InviteForm' do
  describe '#new' do
    let(:user) { create(:user) }
    let(:group) { create(:group) }

    it 'パラメータにgroupとuserを含む場合、インスタンスが作成される' do
      expect(InviteForm.new(group, user)).to be_truthy
    end

    it 'グループがDBに存在しない場合、ArgumentErrorが発生する' do
      expect { InviteForm.new(nil, user) }.to raise_error(ArgumentError)
    end
  end

  describe '#save' do
    let(:group) { create(:group) }

    it 'userがDBに存在し、グループに参加していない時、invitesテーブルにレコードが作成される' do
      expect do
        InviteForm.new(group, create(:user)).save
      end.to change(Invite, :count).by(1)
    end

    it 'userがDBに存在し、グループに参加している時、invitesテーブルにレコードが作成されない' do
      user = create(:user)
      create(:group_user, group:, user:)
      expect { InviteForm.new(group, user).save }.not_to(change(Invite, :count))
    end

    it 'userがDBに存在しない時、invitesテーブルにレコードが作成されない' do
      expect { InviteForm.new(group, build(:user)).save }.not_to(change(Invite, :count))
    end

    it 'userがnilの時、invitesテーブルにレコードが作成されない' do
      expect { InviteForm.new(group, nil).save }.not_to(change(Invite, :count))
    end
  end
end
