class Api::V1::InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all
    render json: @inventories 
  end

  def show
    @inventory = Inventory.find(params[:id])
    @items = @inventory.items
    render json: @items 

  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)

    if @inventory.save
      redirect_to @inventory
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @inventory = Inventory.find(params[:id])
  end

  def update
    @inventory = Inventory.find(params[:id])

    if @inventory.update(inventory_params)
      redirect_to inventories_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def inventory_params
      params.require(:inventory).permit(:category_name, :discription)
    end
end
