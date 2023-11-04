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
class Invite < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_one :accepted_invite, dependent: :destroy
  has_one :rejected_invite, dependent: :destroy

  scope :accepted, -> { where.associated(:accepted_invite) }
  scope :rejected, -> { where.associated(:rejected_invite) }
  scope :unanswered, -> { where.missing(:accepted_invite).where.missing(:rejected_invite) }

  def accept!
    create_accepted_invite!
    group.group_users.create!(user:)
  end

  def reject!
    create_rejected_invite!
  end
end
