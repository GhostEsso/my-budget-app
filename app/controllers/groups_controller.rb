class GroupsController < ApplicationController
  def index
    @groups = current_user.groups
  end

  def show; end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.new(group_params)
    if @group.save
      flash[:success] = 'Category created successfully!'
      redirect_to group_purchases_path(@group)
    else
      flash.now[:error] = @group.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:success] = 'Category updated successfully!'
      redirect_to group_purchases_path(@group)
    else
      flash.now[:error] = @group.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      flash[:success] = 'Category was deleted successfully!'
      redirect_to groups_url
    else
      flash[:error] = @group.errors.full_messages.to_sentence
      render :index
    end
  end

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
