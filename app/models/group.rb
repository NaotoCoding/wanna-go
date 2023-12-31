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
class Group < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :places, dependent: :destroy
  has_many :invites, dependent: :destroy

  validates :name, presence: true

  after_create { group_users.create!(user: owner) }

  def member?(user)
    group_users.find_by(user:).present?
  end

  def owner?(user)
    owner.id == user.id
  end

  def number_of_members
    group_users.count
  end

  def all_invites_answered?(user)
    invites.where(user:).unanswered.blank?
  end
end
