# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  describe 'GET index' do
    it 'renders a successful response' do
      inventory = Inventory.create(category_name: 'inventory_first')
      get :index, params: { inventory_id: inventory.id, item: {} }
      expect(response).to be_successful
    end
  end

  describe 'GET show' do
    it 'renders a successful response' do
      inventory = Inventory.create(category_name: 'inventory_first')
      item = Item.create(name: 'Somename', price: 10, rating: '4', inventory_id: inventory.id)
      get :show, params: { inventory_id: inventory.id, id: item.id }
      expect(response.status).to eq(200)
    end
  end

  describe 'GET new' do
    it 'renders a successful response' do
      inventory = Inventory.create(category_name: 'inventory_first')
      get :new, params: { inventory_id: inventory.id }
      expect(response).to be_successful
    end
  end

  describe 'POST create' do
    it 'create a new product' do
      inventory = Inventory.create(category_name: 'inventory_first')
      post :create,
           params: { inventory_id: inventory.id,
                     item: { name: 'Somename', price: 10, rating: '4', inventory_id: inventory.id } }
      expect(Item.count).to eq(1)
    end
  end

  describe 'GET edit' do
    it 'render a successful response' do
      inventory = Inventory.create(category_name: 'inventory_first')
      item = Item.create(name: 'Somename', price: 10, rating: '4', inventory_id: inventory.id)
      get :edit, params: { inventory_id: inventory.id, id: item.id }
      expect(response.status).to eq(200)
    end
  end

  describe 'PUT update' do
    it 'updates the requested product' do
      inventory = Inventory.create(category_name: 'inventory_first')
      item = Item.create(name: 'Somename', price: 10, rating: '4', inventory_id: inventory.id)
      put :update,
          params: { inventory_id: inventory.id, id: item.id,
                    item: { name: 'Somename', price: 10, rating: '4', inventory_id: inventory.id } }
      expect(response.status).to eq(302)
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested product' do
      inventory = Inventory.create(category_name: 'inventory_first')
      item = Item.create(name: 'Somename', price: 10, rating: '4', inventory_id: inventory.id)
      delete :destroy,
             params: { inventory_id: inventory.id, id: item.id,
                       item: { name: 'Somename', price: 10, rating: '4', inventory_id: inventory.id } }
      expect(response.status).to eq(303)
    end
  end
end
