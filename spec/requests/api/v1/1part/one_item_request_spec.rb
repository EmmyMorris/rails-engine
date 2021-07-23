# frozen_string_literal: true

require 'rails_helper'

describe 'One Item' do
  context 'Get One Item' do
    it 'happy path, fetch one item by id' do
      @item = create(:item)
      id = @item.id
      get "/api/v1/items/#{id}"
      parsed_items = JSON.parse(response.body, symbolize_names: true)
      @items = parsed_items[:data][:attributes]

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      expect(@items).not_to be_empty
      expect(@items.count).to eq(4)
      expect(parsed_items.count).to eq(1)
      expect(parsed_items[:data][:id].to_i).to eq(id)
      expect(response).to be_successful
    end

    it 'sad path, bad integer id returns 404' do
      get '/api/v1/items/8923987297'
      expect(response).to have_http_status(404)
    end

    it 'edge case, string id returns 404' do
      get '/api/v1/items/string-instead-of-integer'
      expect(response).to have_http_status(404)
    end
  end
end
