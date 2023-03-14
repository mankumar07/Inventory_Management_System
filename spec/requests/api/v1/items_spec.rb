# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Items', type: :request do
  describe 'GET /index' do
    let!(:item) { FactoryBot.create(:item) }
    before do
      get "/api/v1/inventories/#{item.inventory_id}/items"
    end

    it 'returns all items' do
      expect(response.status).to eq(200)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let!(:inventory) { FactoryBot.create(:inventory) }
      before do
        post "/api/v1/inventories/#{inventory.id}/items", params:
                                    { inventory_id: inventory.id, item: {
                                      name: 'item_name',
                                      price: 20,
                                      rating: '4',
                                      quantity: '10'
                                    } }
      end
      it 'returns the name' do
        expect(JSON.parse(response.body)['name']).to eq('item_name')
      end

      it 'returns the price' do
        expect(JSON.parse(response.body)['price']).to eq(20)
      end

      it 'returns the rating' do
        expect(JSON.parse(response.body)['rating']).to eq('4')
      end

      it 'returns the quantity' do
        expect(JSON.parse(response.body)['quantity']).to eq(10)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let!(:inventory) { FactoryBot.create(:inventory) }
      before do
        post "/api/v1/inventories/#{inventory.id}/items", params:
                                                          { inventory_id: inventory.id, item: {
                                                            name: 'item_name',
                                                            price: 20,
                                                            rating: '',
                                                            quantity: ''
                                                          } }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /update' do
    # let(:inventory) { FactoryBot.create(:inventory) }
    let!(:item) { FactoryBot.create(:item) }
    before do
      put "/api/v1/inventories/:inventory_id/items/#{item.id}", params:
                                                  { item: {
                                                    name: 'item_name1',
                                                    price: 20,
                                                    rating: '4',
                                                    quantity: '10'
                                                  } }
    end
    it 'returns status code 200' do
      # byebug
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /destroy' do
    let!(:item) { FactoryBot.create(:item) }
    before do
      delete "/api/v1/inventories/:inventory_id/items/#{item.id}"
    end
    it 'returns status code 204' do
      # byebug
      expect(response).to have_http_status(204)
    end
  end
end
