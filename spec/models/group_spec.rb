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

    context '異常なパラメータの場合' do
      it 'nameがnilの時、groupは無効' do
        expect(build(:group, name: nil)).to be_invalid
      end

      it 'nameが空文字の時、groupは無効' do
        expect(build(:group, name: '')).to be_invalid
      end
    end
  end
end
