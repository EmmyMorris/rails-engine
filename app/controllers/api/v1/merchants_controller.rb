class Api::V1::MerchantsController < ApplicationController
  def index
    page = params[:page].to_i || 1
    per_page = not_zero || 20
    m = Merchant.all.offset(page).limit(per_page)
    render json: MerchantSerializer.new(m).serialized_json
  end

  def show
    m = Merchant.find(params[:id])
    render json: MerchantSerializer.new(m).serialized_json
  end

  def not_zero
    if (params[:page].to_i * params[:per_page].to_i) == 0
      (params[:page].to_i * params[:per_page].to_i) == 20
    end
  end
end
