class Api::V1::MerchantItemsController < ApplicationController
  def index
    m = Merchant.find(params[:merchant_id])
    items = m.items
    # require "pry"; binding.pry
    render json: ItemSerializer.new(items).serialized_json
  end
end
