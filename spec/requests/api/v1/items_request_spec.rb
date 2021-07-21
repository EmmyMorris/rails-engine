require 'rails_helper'

describe "All Items" do
  before :each do
    Item.destroy_all
    @all_items = create_list(:item, 50)
  end

  it "happy path, fetch all items" do
    get '/api/v1/items'

    expect(response).to be_successful

    parsed_items = JSON.parse(response.body, symbolize_names: true)
    items = parsed_items[:data]
    expect(items).not_to be_empty
    expect(items.count).to eq(20)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id].to_i).to be_an(Integer)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  describe 'GET /api/v1/items/:id' do
    context 'when the record exists' do
      it "can get one item by its id" do
        id = @all_items[0].id
        get "/api/v1/items/#{id}"
        parsed_items = JSON.parse(response.body, symbolize_names: true)
        @items = parsed_items[:data][:attributes]
        expect(@items).not_to be_empty
        expect(@items.count).to eq(4)
        expect(parsed_items.count).to eq(1)
        expect(parsed_items[:data][:id].to_i).to eq(id)
        expect(response).to be_successful
      end

      it 'returns status code 200' do
        id = @all_items[0].id
        get "/api/v1/items/#{id}"
        parsed_items = JSON.parse(response.body, symbolize_names: true)
        @items = parsed_items[:data][:attributes]
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end
  end
end
