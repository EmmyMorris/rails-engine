class Api::V1::MerchantItemsController < ApplicationController
  def index
    m = Merchant.find(params[:merchant_id])
    items = m.items
    render json: ItemSerializer.new(items).serialized_json, status: :ok
  end
end
