# == Schema Information
#
# Table name: groups
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_groups_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'バリデーション' do
    context '正常なパラメータの場合' do
      it 'groupは有効' do
        expect(build(:group)).to be_valid
      end
    end
  end
end
