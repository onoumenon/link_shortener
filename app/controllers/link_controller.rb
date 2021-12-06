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
      render json: { message: 'URL is invalid', errors: link.errors }, status: :bad_request
    end
  end

  def show
    link = Link.find_by(shortcode: params[:shortcode])

    if link
      uri = URI.parse(link.url)
      if uri.instance_of?(URI::Generic)
        host, path = uri.path.split '/', 2
        uri = URI::HTTP.build host: host,
                              path: "/#{path}",
                              query: uri.query,
                              fragment: uri.fragment
      end
      redirect_to uri.to_s, status: :moved_permanently
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
