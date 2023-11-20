class GroupsController < ApplicationController
  def index
    @groups = current_user.groups
  end

  def show; end

  def new; end

  def edit; end

  def update; end

  def destroy
    @group = Group.find_by(id: params[:id])

    if @group.nil?
      flash[:error] = 'Category not found or already deleted.'
    else
      @group.destroy
      flash[:success] = 'Category has been successfully deleted!'
    end

    redirect_to groups_url
  end
end
