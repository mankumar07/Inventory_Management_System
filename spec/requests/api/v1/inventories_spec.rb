# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Inventories', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:inventory, 1)
      get '/api/v1/inventories'
    end

    it 'returns all inventories' do
      expect(response.status).to eq(200)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      before do
        post '/api/v1/inventories', params:
                                    { inventory: {
                                      category_name: 'inventory_fisrt2',
                                      description: 'whatever you want'
                                    } }
      end
      it 'returns the category_name' do
        expect(JSON.parse(response.body)['category_name']).to eq('inventory_fisrt2')
      end

      it 'returns the description' do
        expect(JSON.parse(response.body)['description']).to eq('whatever you want')
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/inventories', params:
                          { inventory: {
                            category_name: '',
                            description: ''
                          } }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /update' do
    let!(:inventory) { FactoryBot.create(:inventory) }

    before do
      put "/api/v1/inventories/#{inventory.id}", params: {
        inventory: {
          category_name: 'inventory_fisrt2',
          description: 'whatever you want'
        }
      }
    end

    it 'returns status code 200' do
      # byebug
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /destroy' do
    let!(:inventory) { FactoryBot.create(:inventory) }

    before do
      delete "/api/v1/inventories/#{inventory.id}"
    end

    it 'returns status code 204' do
      # byebug
      expect(response).to have_http_status(204)
    end
  end
end
