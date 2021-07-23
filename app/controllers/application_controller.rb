# frozen_string_literal: true

class ApplicationController < ActionController::API
  around_action :handle_errors

  def handle_errors
    yield
  rescue ActiveRecord::RecordNotFound => e
    render_api_error(e.message, 404)
  end

  def render_api_error(messages, code)
    data = { errors: { code: code, details: Array.wrap(messages) } }
    render json: data, status: code
  end

  def page_number
    page = if params[:page].nil?
             params[:page] = 1
           elsif params[:page] == '0'
             params[:page] = 1
           else
             params[:page].to_i
           end
  end

  def per_page
    if params[:per_page].nil?
      params[:per_page] = 20
    else
      params[:per_page].to_i
    end
  end
end
