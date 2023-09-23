class InvitesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:new, :create]

  def index; end

  def new; end

  def create
    user = User.find_by(unique_code: params[:unique_code])
    return render_new_with_error_message('ユーザーが見つかりませんでした') if user.blank?
    return render_new_with_error_message('既に参加しています') if @group.member?(user)

    Invite.create!(group: @group, user:)
    redirect_to group_path(@group), notice: '招待を送信しました'
  end

  private

    def set_group
      @group = current_user.belonging_groups.find(params[:group_id])
    end

    def render_new_with_error_message(message)
      flash.now[:alert] = message
      render :new, status: :unprocessable_entity
    end
end
