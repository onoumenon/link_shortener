class Api::LinkController < ApplicationController
  def create
    link = Link.new(url: link_params)

    if link.save
      render json: link
    else
      render json: { message: 'URL is invalid', errors: link.errors }, status: 400
    end
  end

  def show
    render json: Link.find(params[:id])
  end

  private

  def link_params
    params[:url]
  end
end
