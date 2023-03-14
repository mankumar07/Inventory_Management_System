# frozen_string_literal: true

class InvoicesController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @inventory = Inventory.find(params[:inventory_id])
    @invoices = @user.invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
    @user = User.find(@invoice.user_id)
    @item = Item.find(params[:item_id])
  end

  def new
    @item = Item.find(params[:item_id])
    @invoice = Invoice.new
  end

  def create
    user = User.find(current_user.id)
    @item = Item.find(params[:item_id])
    quantity = params[:invoice][:quantity]
    item_quantity = @item.quantity.to_i - quantity.to_i
    if item_quantity >= 0
      total_price = @item.price * quantity.to_i
      @invoice = user.invoices.create(quantity: params[:invoice][:quantity], total_price: total_price,
                                      item_id: params[:item_id])
      if @invoice.save
        @item.update(quantity: item_quantity)
        redirect_to inventory_item_invoices_path
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to "/inventories/#{params[:inventory_id]}",
                  flash: { notice: 'Sorry too much quantity, please enter available item quantity' }
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @item = Item.find(params[:item_id])
    # invoice_quantity = @item.quantity.to_i+@invoice.quantity.to_i
    @invoice.destroy
    # @item.update(quantity: invoice_quantity)
    redirect_to inventory_item_invoices_path, status: :see_other
  end

  private

  def invoice_params
    params.require(:invoice).permit(:quantity, :total_price)
  end
end
