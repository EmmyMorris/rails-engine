require 'rails_helper'

RSpec.describe MerchantSerializer do
  it 'returns serialized merchants' do
    merchant = create(:merchant)
    serializer = MerchantSerializer.new(merchant)
    expect(serializer.serializable_hash[:data][:attributes][:name]).to eq(merchant.name)
  end
end
