class Api::V1::MerchantsController < ApplicationController
  def index
    limit = (page_number * per_page)
    m = Merchant.all.offset(page_number).limit(limit)
    render json: MerchantSerializer.new(m).serialized_json
  end

  def show
    m = Merchant.find(params[:id])
    render json: MerchantSerializer.new(m).serialized_json
  end
  #
  # def not_zero
  #   if (params[:page].to_i * params[:per_page].to_i) == 0
  #     (params[:page].to_i * params[:per_page].to_i) == 20
  #   end
  # end

  # def page_number
  #   if params[:page].to_i >= 1
  #      params[:page].to_i || 1
  #   else
  #     params[:page] = 1
  #   end
  # end
  #
  # def per_page
  #   if params[:per_page].to_i >= 1
  #      params[:per_page].to_i || 20
  #   else
  #     params[:per_page] = 20
  #   end
  # end
end
