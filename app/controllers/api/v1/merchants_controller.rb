class Api::V1::MerchantsController < ApplicationController
  def index
    m = Merchant.offset((page_number - 1) * per_page).limit(per_page)
    render json: MerchantSerializer.new(m).serialized_json
  end

  def show
    m = Merchant.find(params[:id])
    render json: MerchantSerializer.new(m).serialized_json
    rescue ActiveRecord::RecordNotFound => e
      render_api_error(e.message, 404)
  end
end
