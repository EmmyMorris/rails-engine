require 'rails_helper'

describe "A Merchants Items" do
  before :each do
    Merchant.destroy_all
    @merchant = create(:merchant)
    @item1 = create(:item, merchant: @merchant)
    @item2 = create(:item, merchant: @merchant)
    get api_v1_merchant_items_path(merchant_id: @merchant.id)
    @parsed_merchants = JSON.parse(response.body, symbolize_names: true)
    @merchants = @parsed_merchants[:data]
  end

  it "happy path, fetch all items" do
    expect(response).to have_http_status(200)
    expect(response).to be_successful

    expect(@merchants).not_to be_empty
    expect(@merchants.count).to eq(2)
    expect(@merchants[0].count).to eq(3)
    expect(@merchants[0][:id].to_i).to eq(@item1.id)
    expect(@merchants[1][:id].to_i).to eq(@item2.id)
  end

  it "sad path, bad integer id returns 404" do
    get "/api/v1/merchants/8923987297/items"
    expect(response).to have_http_status(404)
  end
end
