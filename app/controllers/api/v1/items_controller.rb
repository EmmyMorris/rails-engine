class Api::V1::ItemsController < ApplicationController
  def index
    # items = render json: Item.all
    render json: ItemSerializer.new(Item.all)
  end
end
