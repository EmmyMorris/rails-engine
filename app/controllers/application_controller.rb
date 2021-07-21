class ApplicationController < ActionController::API

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
