class Api::V1::ItemsController < ApplicationController
  def index
    items = render json: Item.all
  end
end
