class InvitationsController < ApplicationController
  before_action :set_team
  before_action :redirect_team_if_joined

  def new
  end

  def create
    @team.memberships.create!(user: current_user)
    redirect_to team_url(@team), notice: '参加しました'
  end

  private

  def set_team
    @team = Team.find_by!(token: params[:team_token])
  end

  def redirect_team_if_joined
    if @team.users.exists?(id: current_user.id)
      redirect_to team_url(@team), notice: 'すでに参加済みです'
    end
  end
end