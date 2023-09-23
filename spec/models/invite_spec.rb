# == Schema Information
#
# Table name: invites
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_invites_on_group_id  (group_id)
#  index_invites_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Invite, type: :model do
  describe 'バリデーション' do
    it '正常なパラメータの時、inviteは有効' do
      expect(build(:invite)).to be_valid
    end
  end

  describe '#accept!' do
    let!(:invite) { create(:invite) }

    it 'accepted_invitesテーブルにレコードが保存される' do
      expect { invite.accept! }.to change(AcceptedInvite, :count).by(1)
    end

    it 'group_usersテーブルにレコードが保存される' do
      expect { invite.accept! }.to change(GroupUser, :count).by(1)
    end
  end

  describe '#reject!' do
    it 'rejected_invitesテーブルにレコードが保存される' do
      invite = create(:invite)
      expect { invite.reject! }.to change(RejectedInvite, :count).by(1)
    end
  end
end
