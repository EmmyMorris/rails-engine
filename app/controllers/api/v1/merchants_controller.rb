# frozen_string_literal: true

module Api
  module V1
    class MerchantsController < ApplicationController
      def index
        m = Merchant.offset((page_number - 1) * per_page).limit(per_page)
        render json: MerchantSerializer.new(m).serialized_json, status: :ok
      end

      def show
        m = Merchant.find(params[:id])
        render json: MerchantSerializer.new(m).serialized_json, status: :ok
      end

      def find
        if params[:name] && !params[:name].empty?
          m = Merchant.where('name ILIKE ?', "%#{params[:name]}%").order(:name).first
          if m
            render json: MerchantSerializer.new(m).serialized_json, status: :ok
          else
            render json: { data: {} }, status: :ok
          end
        end
      end
    end
  end
end
