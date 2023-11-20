class PurchasesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @purchases = @group.purchases.order(id: :desc)
  end

  def show
    @purchase = Purchase.find(params[:id])
  end

  def new; end

  def edit; end

  def update; end

  def destroy
    @purchase = Purchase.find_by(id: params[:id])

    if @purchase.nil?
      flash[:error] = 'Transaction not found or already deleted.'
    else
      @purchase.destroy
      flash[:success] = 'Transaction has been successfully deleted!'
    end

    redirect_to group_purchases_url(params[:group_id])
  end
end
