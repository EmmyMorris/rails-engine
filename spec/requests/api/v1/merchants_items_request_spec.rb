require 'rails_helper'

describe "A Merchants Items" do
  before :each do
    @merchant = create(:merchant)
    @id = @merchant.id
    get "/api/v1/merchants/#{@id}/items"
    @parsed_merchants = JSON.parse(response.body, symbolize_names: true)
    @merchants = @parsed_merchants[:data][:attributes]
  end

  it "happy path, fetch all items" do
    expect(response).to have_http_status(200)
    expect(response).to be_successful

    expect(@merchants).not_to be_empty
    expect(@merchants.count).to eq(1)
    expect(@parsed_merchants.count).to eq(1)
    expect(@parsed_merchants[:data][:id].to_i).to eq(@id)
  end

  xit "sad path, bad integer id returns 404" do
    get "/api/v1/merchants/8923987297/items"
    expect(response).to have_http_status(404)
  end
end
