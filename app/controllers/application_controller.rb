class ApplicationController < ActionController::API

  around_action :handle_errors

    def handle_errors
      yield
    rescue ActiveRecord::RecordNotFound => e
      render_api_error(e.message, 404)
    rescue ActiveRecord::RecordInvalid => e
      render_api_error(e.record.errors.full_messages, 422)
    rescue JWT::ExpiredSignature => e
      render_api_error(e.message, 401)
    rescue InvalidTokenError => e
      render_api_error(e.message, 422)
    rescue MissingTokenError => e
      render_api_error(e.message, 422)
    end

    def render_api_error(messages, code)
      data = { errors: { code: code, details: Array.wrap(messages) } }
      render json: data, status: code
    end

  def page_number
    if params[:page].nil?
       page = params[:page] = 1
    elsif params[:page] == "0"
      page = params[:page] = 1
    else
      page = params[:page].to_i
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
