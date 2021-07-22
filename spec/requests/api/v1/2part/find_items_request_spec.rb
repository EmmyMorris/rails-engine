require 'rails_helper'

describe "Finds All Items" do
  before :each do
    Item.destroy_all
    @all_items = create_list(:item, 200)
  end

  it "happy path, fetch all items matching a pattern" do
    get '/api/v1/items/find_all?name=hA'
    expect(response).to be_successful

    parsed_items = JSON.parse(response.body, symbolize_names: true)
    items = parsed_items[:data]
    # require "pry"; binding.pry

    expect(items).to be_an(Array)
    expect(items).not_to be_empty
    # expect(items.count).to eq(20)

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

  it "sad path, no fragment matched" do
    get '/api/v1/items/find_all?name=NOMATCH'

    parsed_merchant = JSON.parse(response.body, symbolize_names: true)
    merchant = parsed_merchant[:data]
    expect(merchant).to be_an(Array)
    expect(response).to have_http_status(200)
  end
end
