class RejectedInvitesController < ApplicationController
  before_action :authenticate_user!

  def create
    invite = current_user.received_invites.find(params[:invite_id])
    invite.reject!
    redirect_to invites_path, notice: '招待を拒否しました'
  end
end
