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
FactoryBot.define do
  factory :rejected_invite do
    invite { nil }
  end
end
