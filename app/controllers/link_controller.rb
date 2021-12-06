class LinkController < ApplicationController
  def create
    shortcode = generate_shortcode
    link = Link.new(url: link_params, shortcode: shortcode)

    if link.save
      render json: {
        base_url: request.base_url,
        shortcode: shortcode,
        short_url: "#{request.base_url}/#{shortcode}"
      }
    else
      render json: { message: 'URL is invalid', errors: link.errors }, status: 400
    end
  end

  def show
    render json: Link.find_by(shortcode: params[:shortcode])
  end

  private

  def generate_shortcode
    shortcode = SecureRandom.base36(8)
    shortcode = SecureRandom.base36(8) while Link.exists?(shortcode: shortcode)
    shortcode
  end

  def link_params
    params[:url]
  end
end
