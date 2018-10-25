class MypageController < ApplicationController
  before_action :redirect_edit_unless_inputted, only: %i(show)
  before_action :set_user, only: %i(edit update)

  def show
  end

  def edit
    (5 - @user.strengths.count).times do
      @user.strengths.build
    end
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_url, notice: t('controllers.updated')
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    if params[:user] && params[:user][:strengths_attributes]
      params[:user][:strengths_attributes].each do |key|
        params[:user][:strengths_attributes][key][:position] = key
      end
    end
    params.fetch(:user, {}).permit(strengths_attributes: [:id, :nature, :position, :_destroy])
  end

  def redirect_edit_unless_inputted
    unless current_user.inputted?
      redirect_to edit_mypage_url, notice: 'つよみを登録してください'
    end
  end
end
