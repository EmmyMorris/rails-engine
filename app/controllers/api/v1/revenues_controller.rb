class Api::V1::RevenuesController < ApplicationController
  def top_merchants
    m = Merchant.most_revenue(params[:quantity])
    render json: MerchantSerializer.new(m).serialized_json, status: :ok
  end
end
