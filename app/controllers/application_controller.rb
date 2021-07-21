class ApplicationController < ActionController::API
  def page_number
    if params[:page].to_i >= 1
       params[:page].to_i || 1
    else
      params[:page] = 1
    end
  end

  def per_page
    if params[:per_page].to_i >= 1
       params[:per_page].to_i || 20
    else
      params[:per_page] = 20
    end
  end
end
