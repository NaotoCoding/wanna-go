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

  has_many :accepted_invites, dependent: :destroy
  has_many :rejected_invites, dependent: :destroy

  scope :accepted, -> { where.associated(:accepted_invites) }
  scope :rejected, -> { where.associated(:rejected_invites) }
  scope :unanswered, -> { where.missing(:accepted_invites).where.missing(:rejected_invites) }

  def accept!
    accepted_invites.create!
  end
end
