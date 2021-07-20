require 'rails_helper'

describe "Merchants API" do
  before :each do
    @all_merchants = create_list(:merchant, 50)
  end
  it "sends all merchants" do
    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(20)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)
      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_an(String)
    end
  end

  it "sends all merchants on first page" do
    get '/api/v1/merchants?page=1&per_page=20'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.count).to eq(20)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)
      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_an(String)
    end
  end

  describe 'GET /api/v1/merchants/:id' do
    context 'when the record exists' do
      it "can get one merchant by its id" do
        id = @all_merchants[0].id
        get "/api/v1/merchants/#{id}"
        @merchants = JSON.parse(response.body, symbolize_names: true)
        expect(@merchants).not_to be_empty
        expect(@merchants.count).to eq(2)
        expect(@merchants[:id]).to eq(id)
        expect(response).to be_successful
      end

      it 'returns status code 200' do
        id = @all_merchants[0].id
        get "/api/v1/merchants/#{id}"
        @merchants = JSON.parse(response.body, symbolize_names: true)
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end

    # context 'when the record does not exist' do
    #   it 'returns status code 404' do
    #     get "/api/v1/merchants/100"
    #     expect(response).to have_http_status(404)
    #   end
    #
    #   it 'returns a not found message' do
    #     get "/api/v1/merchants/100"
    #     expect(response.body).to match(/Couldn't find Merchant/)
    #   end
    # end


  end
end
