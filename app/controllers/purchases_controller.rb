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
      flash.now[:error] = 'You must choose at least one category!'
      render :new
    elsif @purchase.save
      @groups.each do |group|
        group.purchases << @purchase
      end
      flash[:success] = "Transaction was created and added to #{@groups.length} goups!"
      redirect_to group_purchases_path(params[:group_id])
    else
      flash.now[:error] = @purchase.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @purchase = Purchase.find(params[:id])
  end

  def update
    @purchase = Purchase.find(params[:id])
    @groups = Group.where(id: purchase_params[:group_ids])
    if @groups.empty?
      flash.now[:error] = 'You must choose at least one category!'
      render :edit
    elsif @purchase.update(purchase_params.except(:group_ids))
      @groups.each do |group|
        group.purchases << @purchase unless group.purchases.include?(@purchase)
      end
      flash[:succes] = 'Transaction updated successfully!'
      redirect_to group_purchase_path(params[:group_id], params[:id])
    else
      flash.now[:error] = @purchase.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @purchase = Purchase.find(params[:id])
    if @purchase.destroy
      flash[:success] = 'Transaction was deleted successfully!'
      redirect_to group_purchases_url(params[:group_id])
    else
      flash.now[:error] = @purchase.errors.full_messages.to_sentence
      render :show
    end
  end

  def purchase_params
    params.require(:purchase).permit(:name, :amount, group_ids: [])
  end
end
