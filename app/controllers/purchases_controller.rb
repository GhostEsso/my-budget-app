class PurchasesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @purchases = @group.purchases.order(id: :desc)
  end

  def show
    @purchase = Purchase.find(params[:id])
  end

  def new
    @groups = current_user.groups
    @purchase = Purchase.new
    # Création d'un nombre initial de group_purchases associés à la purchase
    # La quantité dépend du nombre de groupes de l'utilisateur actuel
    @groups.size.times { @purchase.group_purchases.build }
  end

  def create
    @purchase = current_user.purchases.new(purchase_params)

    if @purchase.save
      redirect_to group_purchases_path(params[:group_id]), success: 'Purchase was successfully created!'
    else
      @groups = current_user.groups
      render :new, alert: 'Failed to create purchase!'
    end
  end

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

  def purchase_params
    params.require(:purchase).permit(:name, :amount, group_purchases_attributes: :group_id)
  end
end
