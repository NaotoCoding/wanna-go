class InvitesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:new, :create]

  def index
    @unconfirmed_invites = current_user.received_invites.unanswered
  end

  def new
    @invite_form = InviteForm.new(@group, User.new)
  end

  def create
    @invite_form = InviteForm.new(@group, User.find_by(unique_code: params[:unique_code]))
    if @invite_form.save
      redirect_to group_path(@group), notice: '招待を送信しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def set_group
      @group = current_user.belonging_groups.find(params[:group_id])
    end
end
