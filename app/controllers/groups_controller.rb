class GroupsController < ApplicationController
  def index
    @groups = current_user.groups
  end

  def show; end

  def new; end

  def edit; end

  def update; end

  def delete; end
end
