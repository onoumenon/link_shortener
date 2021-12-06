class LinkController < ApplicationController
  def create
    shortcode = generate_shortcode
    link = Link.new(url: link_params, shortcode: shortcode)

    if link.save
      render json: {
        base_url: request.base_url,
        shortcode: shortcode
      }
    else
      render json: { message: 'URL is invalid', errors: link.errors }, status: :bad_request
    end
  end

  def show
    link = Link.find_by(shortcode: params[:shortcode])

    if link
      redirect_to link.url, status: :moved_permanently
      nil
    else
      render json: { message: 'Link not found' }, status: :not_found
    end
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
