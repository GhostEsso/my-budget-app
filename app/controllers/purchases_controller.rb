class PurchasesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @purchases = @group.purchases.order(id: :desc)
  end

  def show
    @purchase = Purchase.find(params[:id])
  end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = current_user.purchases.new(purchase_params.except(:group_ids))
    @groups = Group.where(id: purchase_params[:group_ids])
  
    if @groups.empty?
      flash.now[:error] = "You must choose at least one category!"
      render :new
    else
      ActiveRecord::Base.transaction do
        if @purchase.save
          @groups.each { |group| group.purchases << @purchase }
          flash[:success] = "Transaction was created and added to #{@groups.length} groups!"
          redirect_to group_purchases_path(params[:group_id])
        else
          flash.now[:error] = @purchase.errors.full_messages.to_sentence
          render :new
          raise ActiveRecord::Rollback
        end
      end
    end
  end
  

  def edit; end

  def update; end

  def destroy
    @purchase = Purchase.find_by_id(params[:id])
  
    if @purchase
      @purchase.destroy
      flash[:success] = 'Transaction was successfully deleted!'
    else
      flash[:error] = 'Transaction not found!'
    end
  
    redirect_to group_purchases_url(params[:group_id])
  end
  

  def purchase_params
    params.require(:purchase).permit(:name, :amount, group_ids: [])
  end
end
