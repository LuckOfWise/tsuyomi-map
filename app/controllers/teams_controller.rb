class TeamsController < ApplicationController
  before_action :set_team, only: %i(show edit update destroy)

  def show
    @users = @team.users.order(:id)
  end

  def new
    @team = current_user.teams.build
  end

  def create
    @team = current_user.teams.build(team_params)
    @team.current_user = current_user
    if @team.save
      redirect_to team_url(@team), notice: t('controllers.created')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to team_url(@team), notice: t('controllers.updated')
    else
      render :edit
    end
  end

  def destroy
    @team.destroy!
    redirect_to mypage_url, notice: t('controllers.destroyed')
  end

  private

  def set_team
    @team = current_user.teams.find(params[:id])
  end

  def team_params
    params.fetch(:team, {}).permit(:name)
  end
end
