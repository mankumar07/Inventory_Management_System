# frozen_string_literal: true

module Api
  module V1
    class InventoriesController < ApplicationController
      protect_from_forgery with: :null_session
      def index
        @inventories = Inventory.all
        render json: @inventories
      end

      def show
        @inventory = Inventory.find(params[:id])
        @items = @inventory.items
        render json: @items
      end

      def create
        @inventory = Inventory.new(inventory_params)

        if @inventory.save
          # redirect_to @inventory
          render json: @inventory, status: :created
        else
          render json: @inventory.errors, status: :unprocessable_entity
        end
      end

      def update
        @inventory = Inventory.find(params[:id])

        if @inventory.update(inventory_params)
          # redirect_to inventories_path
          render json: { message: 'Inventory updated successfully' }
        else
          render json: { message: @inventory.errors.messages }
        end
      end

      def destroy
        @inventory = Inventory.find(params[:id])
        @inventory.destroy

        # redirect_to root_path, status: :see_other
        # render json: { message: 'Inventory deleted successfully' }
        render json: @inventory, status: :no_content
      end

      private

      def inventory_params
        params.require(:inventory).permit(:category_name, :description)
      end
    end
  end
end
