require 'rails_helper'

describe "All Merchants" do
  before :each do
    Merchant.destroy_all
    @all_merchants = create_list(:merchant, 100)
  end

  it "happy path, fetching all merchants" do
    get '/api/v1/merchants'
    expect(response).to be_successful

    parsed_merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed_merchants[:data]
    expect(merchants).to be_an(Array)
    expect(merchants).not_to be_empty
    expect(merchants.count).to eq(20)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end

  it "happy path, fetching page 1 is the same list of first 20 in db" do
    get '/api/v1/merchants?page=1'
    expect(response).to be_successful

    parsed_merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed_merchants[:data]
    expect(merchants).to be_an(Array)
    expect(merchants).not_to be_empty
    expect(merchants.count).to eq(20)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end


  it "happy path, fetch second page of 20 merchants" do
    get '/api/v1/merchants?page=2'
    expect(response).to be_successful

    parsed_merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed_merchants[:data]
    expect(merchants).to be_an(Array)
    expect(merchants).not_to be_empty
    expect(merchants.count).to eq(20)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end

  it "happy path, fetch first page of 50 merchants" do
    get '/api/v1/merchants?per_page=50'
    expect(response).to be_successful

    parsed_merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed_merchants[:data]
    expect(merchants).to be_an(Array)
    expect(merchants).not_to be_empty
    expect(merchants.count).to eq(50)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end

  it "happy path, fetch a page of merchants which would contain no data" do
    get '/api/v1/merchants?page=200'
    expect(response).to be_successful

    parsed_merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed_merchants[:data]
    expect(merchants).to be_an(Array)
    expect(merchants).to be_empty
    expect(merchants.count).to eq(0)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end

  it "happy path, fetch all merchants if per page is really big" do
    get '/api/v1/merchants?per_page=200'
    expect(response).to be_successful

    parsed_merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed_merchants[:data]
    expect(merchants).to be_an(Array)
    expect(merchants).not_to be_empty
    expect(merchants.count).to eq(100)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end
  
  it "sad path, fetching page 1 if page is 0 or lower" do
    get '/api/v1/merchants?page=0'
    expect(response).to be_successful

    parsed_merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed_merchants[:data]
    expect(merchants).to be_an(Array)
    expect(merchants).not_to be_empty
    expect(merchants.count).to eq(20)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end
end
