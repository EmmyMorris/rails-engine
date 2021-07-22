require 'rails_helper'

describe "Find One Merchant" do
  before :each do
    Merchant.destroy_all
    @all_merchants = create_list(:merchant, 100)
  end

  it "happy path, fetch one merchant by fragment" do
    get '/api/v1/merchants/find?name=iLl'
    expect(response).to be_successful

    parsed_merchant = JSON.parse(response.body, symbolize_names: true)
    merchant = parsed_merchant[:data]
    
    expect(merchant).to be_an(Hash)
    expect(parsed_merchant.count).to eq(1)
    expect(merchant.count).to eq(3)
    expect(merchant).not_to be_empty
    expect(merchant[:id].to_i).to be_an(Integer)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_an(String)
  end

  it "sad path, no fragment matched" do
    get '/api/v1/merchants/find?name=NOMATCH'

    parsed_merchant = JSON.parse(response.body, symbolize_names: true)
    merchant = parsed_merchant[:data]
    expect(merchant).to be_an(Hash)
    expect(response).to have_http_status(200)
  end
end
