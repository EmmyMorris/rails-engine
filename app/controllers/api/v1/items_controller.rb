class Api::V1::ItemsController < ApplicationController
  def index
    i = Item.offset((page_number - 1) * per_page).limit(per_page)
    render json: ItemSerializer.new(i).serialized_json, status: :ok
  end

  def show
    i = Item.find(params[:id])
    render json: ItemSerializer.new(i).serialized_json, status: :ok
  end
end
