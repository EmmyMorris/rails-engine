class Api::V1::MerchantsController < ApplicationController
  def index
    # params_page = params[:page].to_i
    # params_per_page = params[:per_page].to_i
    page = params[:page] || 0
    per_page = params[:per_page] || 20
    merchants = render json: Merchant.all.offset(page).limit(per_page)
  end

  def show
    render json: Merchant.find(params[:id])
  end
end
