require 'rails_helper'

RSpec.describe ItemSerializer do
  it 'returns serialized items' do
    item = create(:item)
    serializer = ItemSerializer.new(item)
    expect(serializer.serializable_hash[:data][:attributes][:name]).to eq(item.name)
    expect(serializer.serializable_hash[:data][:attributes][:description]).to eq(item.description)
    expect(serializer.serializable_hash[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(serializer.serializable_hash[:data][:attributes][:merchant_id]).to eq(item.merchant.id)
  end
end
