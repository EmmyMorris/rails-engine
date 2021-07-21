class Api::V1::MerchantsController < ApplicationController
  def index
    # require "pry"; binding.pry
    params_page = params[:page].to_i
    params_per_page = params[:per_page].to_i
    page = params_page || 1
    per_page = not_zero || 20
    #
    # page = params[:page] || 0
    # per_page = (params[:page] * params[:per_page]) || 20
    m = Merchant.all.offset(page).limit(per_page)
    render json: MerchantSerializer.new(m).serialized_json
  end

  def show
    m = Merchant.find(params[:id])
    render json: MerchantSerializer.new(m).serialized_json
  end

  def not_zero
    if (params[:page].to_i * params[:per_page].to_i) == 1
      (params[:page].to_i * params[:per_page].to_i) == 20
    end
  end
end
