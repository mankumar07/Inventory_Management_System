# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InventoriesController, type: :controller do
  describe 'GET index' do
    it 'renders a successful response' do
      get :index

      expect(response).to be_successful
    end
  end

  describe 'GET show' do
    it 'renders a successful response' do
      inventory = Inventory.create(category_name: 'inventory_first')
      get :show, params: { id: inventory.id }
      expect(response.status).to eq(200)
    end
  end
end
