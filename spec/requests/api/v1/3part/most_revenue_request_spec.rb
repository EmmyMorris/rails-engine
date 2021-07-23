# frozen_string_literal: true

require 'rails_helper'

describe 'Merchants with Most Revenue' do
  before :each do
    Merchant.destroy_all
    @all_merchants = create_list(:merchant, 100)
  end

  xit 'happy path, fetch top 10 merchants by revenue' do
    get '/api/v1/revenue/merchants?quantity=10'
    expect(response).to be_successful

    parsed_merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed_merchants[:data]
    expect(merchants).to be_an(Array)
    expect(merchants).not_to be_empty
    expect(merchants.count).to eq(10)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end

  xit 'happy path, top one merchant by revenue' do
    get '/api/v1/revenue/merchants?quantity=1'
    expect(response).to be_successful

    parsed_merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed_merchants[:data]
    expect(merchants).to be_an(Array)
    expect(merchants).not_to be_empty
    expect(merchants.count).to eq(1)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id].to_i).to be_an(Integer)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_an(String)
    end
  end

  xit 'happy path, all 100 merchants if quantity is too big' do
    get '/api/v1/revenue/merchants?quantity=1000000'
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

  xit 'edge case sad path, quantity param is missing' do
    get '/api/v1/revenue/merchants'
    expect(response).to be_successful
    expect(response).to have_http_status(400)

    parsed_merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed_merchants[:data]
    expect(merchants).to be_an(Array)
    expect(merchants).to be_empty
  end

  xit 'sad path, returns an error of some sort if quantity value is blank' do
    get '/api/v1/revenue/merchants?quantity='
    expect(response).to be_successful
    expect(response).to have_http_status(400 || 500)

    parsed_merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed_merchants[:data]
    expect(merchants).to be_an(Array)
    expect(merchants).to be_empty
  end

  xit 'sad path, returns an error of some sort if quantity is a string' do
    get '/api/v1/revenue/merchants?quantity=asdasd'
    expect(response).to be_successful
    expect(response).to have_http_status(400 || 500)

    parsed_merchants = JSON.parse(response.body, symbolize_names: true)
    merchants = parsed_merchants[:data]
    expect(merchants).to be_an(Array)
    expect(merchants).to be_empty
  end
end
