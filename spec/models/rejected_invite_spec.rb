# == Schema Information
#
# Table name: rejected_invites
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  invite_id  :bigint           not null
#
# Indexes
#
#  index_rejected_invites_on_invite_id  (invite_id)
#
# Foreign Keys
#
#  fk_rails_...  (invite_id => invites.id)
#
require 'rails_helper'

RSpec.describe RejectedInvite, type: :model do
  describe 'バリデーション' do
    it '正常なパラメータの時、rejected_inviteは有効' do
      expect(build(:rejected_invite)).to be_valid
    end
  end
end
