require 'rails_helper'

describe "All Items" do
  before :each do
    Item.destroy_all
    @all_items = create_list(:item, 100)
  end

  it "happy path, fetch all items" do
    get '/api/v1/items'
    expect(response).to be_successful

    parsed_items = JSON.parse(response.body, symbolize_names: true)
    items = parsed_items[:data]
    expect(items).to be_an(Array)
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

  it "happy path, fetching page 1 is the same list of first 20 in db" do
    get '/api/v1/items?page=1'
    expect(response).to be_successful

    parsed_items = JSON.parse(response.body, symbolize_names: true)
    items = parsed_items[:data]
    expect(items).to be_an(Array)
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


  it "happy path, fetch second page of 20 items" do
    get '/api/v1/items?page=2'
    expect(response).to be_successful

    parsed_items = JSON.parse(response.body, symbolize_names: true)
    items = parsed_items[:data]
    expect(items).to be_an(Array)
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

  it "happy path, fetch first page of 50 items" do
    get '/api/v1/items?per_page=50'
    expect(response).to be_successful

    parsed_items = JSON.parse(response.body, symbolize_names: true)
    items = parsed_items[:data]
    expect(items).to be_an(Array)
    expect(items).not_to be_empty
    expect(items.count).to eq(50)

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

  it "happy path, fetch a page of items which would contain no data" do
    get '/api/v1/items?page=200'
    expect(response).to be_successful

    parsed_items = JSON.parse(response.body, symbolize_names: true)
    items = parsed_items[:data]
    expect(items).to be_an(Array)
    expect(items).to be_empty
    expect(items.count).to eq(0)

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

  it "happy path, fetch all items if per page is really big" do
    get '/api/v1/items?per_page=200'
    expect(response).to be_successful

    parsed_items = JSON.parse(response.body, symbolize_names: true)
    items = parsed_items[:data]
    expect(items).to be_an(Array)
    expect(items).not_to be_empty
    expect(items.count).to eq(100)

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
  
  it "sad path, fetching page 1 if page is 0 or lower" do
    get '/api/v1/items?page=0'
    expect(response).to be_successful

    parsed_items = JSON.parse(response.body, symbolize_names: true)
    items = parsed_items[:data]
    expect(items).to be_an(Array)
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
end
