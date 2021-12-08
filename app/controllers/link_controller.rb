class LinkController < ApplicationController
  def create
    shortcode = generate_shortcode
    link = Link.new(url: link_param, shortcode: shortcode)

    if link.save
      render json: {
        shortcode: shortcode,
        short_url: "#{request.base_url}/#{shortcode}"
      }
    else
      render json: { message: 'URL is invalid', errors: link.errors }, status: :bad_request
    end
  end

  def show
    link = Link.find_by(shortcode: shortcode_param)
    if link
      uri = URI.parse(link.url)
      uri.instance_of?(URI::Generic) && uri = build_url(uri)
      redirect_to uri.to_s, status: :moved_permanently
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

  def build_url(uri)
    host, path = uri.path.split '/', 2
    URI::HTTP.build host: host,
                    path: "/#{path}",
                    query: uri.query,
                    fragment: uri.fragment
  end

  def link_param
    params[:url]
  end

  def shortcode_param
    params[:shortcode]
  end
end
