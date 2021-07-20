require 'rails_helper'

describe "Items API" do
  it "sends all items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    require "pry"; binding.pry
    expect(items.count).to eq(3)

    # items.each do |item|
    #   expect(item).to have_key(:id)
    #   expect(item[:id]).to be_an(Integer)
    #
    #   expect(merchant).to have_key(:name)
    #   expect(merchant[:name]).to be_an(String)
    # end
  end
end
