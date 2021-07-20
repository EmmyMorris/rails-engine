require 'rails_helper'

RSpec.describe ItemSerializer do
  it 'returns serialized items' do
    item = create(:item)
    serializer = ItemSerializer.new(item)
    expect(serializer.serializable_hash[:name]).to eq(item.name)
    expect(serializer.serializable_hash[:description]).to eq(item.description)
    expect(serializer.serializable_hash[:unit_price]).to eq(item.unit_price)
    expect(serializer.serializable_hash[:merchant]).to eq(item.merchant)
  end
end
