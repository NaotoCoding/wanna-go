# == Schema Information
#
# Table name: group_users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  group_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_group_users_on_group_id  (group_id)
#  index_group_users_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (group_id => groups.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe GroupUser, type: :model do
  describe 'バリデーション' do
    context '正常なパラメータの場合' do
      it 'group_userは有効' do
        expect(build(:group_user)).to be_valid
      end
    end
  end
end
