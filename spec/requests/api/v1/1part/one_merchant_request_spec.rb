require 'rails_helper'

describe "One Merchant" do
  context 'Get One Merchant' do
    it "happy path, fetch one merchant by id" do
      @merchant = create(:merchant)
      id = @merchant.id
      get "/api/v1/merchants/#{id}"
      parsed_merchants = JSON.parse(response.body, symbolize_names: true)
      @merchants = parsed_merchants[:data][:attributes]

      expect(response).to have_http_status(200)
      expect(response).to be_successful

      expect(@merchants).not_to be_empty
      expect(@merchants.count).to eq(1)
      expect(parsed_merchants.count).to eq(1)
      expect(parsed_merchants[:data][:id].to_i).to eq(id)
    end

    it "sad path, bad integer id returns 404" do
      get "/api/v1/merchants/8923987297"
      expect(response).to have_http_status(404)
    end
  end
end
