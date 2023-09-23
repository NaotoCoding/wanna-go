# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unique_code            :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unique_code           (unique_code) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    context '正常なパラメータの場合' do
      it 'userは有効' do
        expect(build(:user)).to be_valid
      end
    end

    context '異常なパラメータの場合' do
      it 'unique_codeに重複がある場合、userは無効' do
        create(:user, unique_code: 'duplicated_unique_code')
        expect(build(:user, unique_code: 'duplicated_unique_code')).to be_invalid
      end

      it 'unique_codeが5文字より短い文字列の時、userは無効' do
        expect(build(:user, unique_code: 'uniq')).to be_invalid
      end

      it 'unique_codeが30文字より長い文字列の時、userは無効' do
        expect(build(:user, unique_code: 'a' * 31)).to be_invalid
      end

      where(:key, :value) do
        [
          [:name, nil],
          [:name, ''],
          [:unique_code, nil],
          [:unique_code, '']
        ]
      end

      with_them do
        it "#{params[:key]}が#{params[:value]}の時、userは無効" do
          expect(build(:user, key => value)).to be_invalid
        end
      end
    end
  end
end
