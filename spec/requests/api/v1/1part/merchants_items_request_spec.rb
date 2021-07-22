require 'rails_helper'

describe "A Merchants Items" do
  before :each do
    Merchant.destroy_all
    @merchant = create(:merchant)
    @item1 = create(:item, merchant: @merchant)
    @item2 = create(:item, merchant: @merchant)
    @item3 = create(:item, merchant: @merchant)
    get api_v1_merchant_items_path(merchant_id: @merchant.id)
    @parsed_merchant_items = JSON.parse(response.body, symbolize_names: true)
    @merchant_items = @parsed_merchant_items[:data]
  end

  it "happy path, fetch all items" do
    expect(response).to have_http_status(200)
    expect(response).to be_successful

    expect(@merchant_items).not_to be_empty
    expect(@merchant_items.count).to eq(3)
    expect(@merchant_items[0].count).to eq(3)
    expect(@merchant_items[0][:id].to_i).to eq(@item1.id)
    expect(@merchant_items[1][:id].to_i).to eq(@item2.id)
    expect(@merchant_items[2][:id].to_i).to eq(@item3.id)
  end

  it "sad path, bad integer id returns 404" do
    get "/api/v1/merchants/8923987297/items"
    expect(response).to have_http_status(404)
  end
end
