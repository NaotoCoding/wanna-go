class AcceptedInvitesController < ApplicationController
  before_action :authenticate_user!

  def create
    invite = current_user.received_invites.find(params[:invite_id])
    invite.accept!
    redirect_to group_url(invite.group), notice: '招待を承認しました'
  end
end
