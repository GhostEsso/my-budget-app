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

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
