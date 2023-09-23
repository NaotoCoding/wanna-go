class RejectedInvitesController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.received_invites.find(params[:invite_id]).reject!
    redirect_to invites_path, notice: '招待を拒否しました'
  end
end
