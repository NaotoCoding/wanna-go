require 'rails_helper'

RSpec.describe 'Places', type: :request do
  describe 'ログインせずにアクションを実行した場合' do
    it 'ログイン画面にリダイレクトされる' do
      get new_group_invite_path(create(:group))
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET /groups/:group_id/places/:id' do
    it '行きたい場所詳細画面が表示される' do
      user = create(:user)
      sign_in user
      place = create(:place, group: create(:group, owner: user), user:)
      get group_place_path(place.group, place)
      expect(response).to have_http_status 200
    end
  end

  describe 'GET /groups/:group_id/places/new' do
    it '行きたい場所作成画面が表示される' do
      user = create(:user)
      sign_in user
      get new_group_place_path(create(:group, owner: user))
      expect(response).to have_http_status 200
    end
  end

  describe 'POST /groups/:group_id/places' do
    let!(:user) { create(:user) }
    let!(:group) { create(:group, owner: user) }

    subject(:post_place) { post group_places_path(group), params: place_params }

    before do
      sign_in user
    end

    context 'パラメータが正常な場合' do
      let(:place_params) { { place: { name: '浅草寺', description: '東京のお寺', url: 'https://www.senso-ji.jp/' } } }

      it 'placeが作成される' do
        expect { post_place }.to change(Place, :count).by(1)
      end

      it 'group_places_pathにリダイレクトされる' do
        expect(post_place).to redirect_to group_path(group)
      end
    end

    context 'パラメータが異常な場合' do
      let(:place_params) { { place: { name: '', description: '東京のお寺', url: 'https://www.senso-ji.jp/' } } }

      it 'placeが作成されない' do
        expect { post_place }.not_to change(Place, :count)
      end

      it 'バリデーションエラーが返される' do
        post_place
        expect(response).to have_http_status 422
      end
    end
  end

  describe 'GET /groups/:group_id/places/:id/edit' do
    it '行きたい場所編集画面が表示される' do
      owner = create(:user)
      group = create(:group, owner:)
      sign_in owner
      get edit_group_place_path(group, create(:place, group:))
      expect(response).to have_http_status 200
    end
  end

  describe 'PUT /groups/:group_id/places/:id' do
    let(:group) { create(:group) }
    let(:user) { create(:user) }
    let(:place) { create(:place, group:, user: group.owner) }

    subject(:put_place) { put group_place_path(group, place), params: update_params }

    before do
      create(:group_user, group:, user:)
      sign_in user
    end

    context 'パラメータが正常な場合' do
      let(:update_params) { { place: { name: '浅草寺', description: '東京のお寺', url: 'https://www.senso-ji.jp/' } } }

      it 'グループメンバーは誰でも行きたい場所が更新できる' do
        expect { put_place }.to change { place.reload.name }.from(place.name).to('浅草寺')
      end

      it '行きたい場所詳細画面にリダイレクトされる' do
        put_place
        expect(response).to redirect_to group_place_url(group, place)
      end

      it 'グループメンバー以外が更新しようとすると例外を発生させる' do
        sign_out user
        sign_in create(:user)
        expect { put_place }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'パラメータが異常な場合' do
      let(:update_params) { { place: { name: '', description: '東京のお寺', url: 'https://www.senso-ji.jp/' } } }

      it '行きたい場所が更新されない' do
        expect { put_place }.not_to(change { place.reload.name })
      end

      it 'バリデーションエラーが返される' do
        put_place
        expect(response).to have_http_status 422
      end
    end
  end
end
