# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      protect_from_forgery with: :null_session
      def index
        @items = Item.all
        render json: @items
      end

      def show
        @item = Item.find(params[:id])
        render json: @item
      end

      def create
        inventory = Inventory.find(params[:inventory_id])
        @item = inventory.items.new(item_params)

        if @item.save
          # SendEmailJob.perform_later(@item)
          render json: @item, status: :created
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      def update
        @item = Item.find(params[:id])

        if @item.update(item_params)
          # SendEmailJob.set(wait: 3.minutes).perform_later(@item)
          render json: { message: 'Item updated successfully' }
        else
          render json: { message: @item.errors.messages }
        end
      end

      def destroy
        @item = Item.find(params[:id])
        @item.destroy

        render json: @item, status: :no_content
      end

      private

      def item_params
        params.require(:item).permit(:name, :price, :rating, :quantity)
      end
    end
  end
end
