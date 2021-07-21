class Api::V1::ItemsController < ApplicationController
  def index
    page = params[:page].to_i || 1
    per_page = not_zero || 20
    i = Item.all.offset(page).limit(per_page)
    render json: ItemSerializer.new(i).serialized_json
  end

  def show
    i = Item.find(params[:id])
    render json: ItemSerializer.new(i).serialized_json
  end

  def not_zero
    if (params[:page].to_i * params[:per_page].to_i) == 0
      (params[:page].to_i * params[:per_page].to_i) == 20
    end
  end
end
