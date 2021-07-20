class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all
    render json: MerchantSerializer.format_merchants(merchants).first(20)
  end

  def show
    render json: Merchant.find(params[:id])
  end
end
