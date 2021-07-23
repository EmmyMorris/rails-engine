# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      def index
        i = Item.offset((page_number - 1) * per_page).limit(per_page)
        render json: ItemSerializer.new(i).serialized_json, status: :ok
      end

      def show
        i = Item.find(params[:id])
        render json: ItemSerializer.new(i).serialized_json, status: :ok
      end

      def find_all
        i = Item.where('name ILIKE ?', "%#{params[:name]}%").order(:name)
        render json: ItemSerializer.new(i).serialized_json, status: :ok
      end
    end
  end
end
