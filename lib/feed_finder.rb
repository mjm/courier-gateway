require 'feed_type'

class FeedFinder
  attr_reader :url

  def initialize(url)
    @url = Addressable::URI.heuristic_parse(url, scheme: 'https')
                           .normalize.to_s
  end
  private_class_method :new

  def self.find(url)
    new(url).feed_url
  end

  def feed_url
    attempt_url url
  end

  def attempt_url(url)
    handle_response get_url(url)
  end

  def get_url(url)
    Faraday.new(url) { |conn|
      conn.response :follow_redirects
      conn.adapter :typhoeus
    }.get
  end

  def handle_response(response)
    case response.status
    when 200 then handle_successful_response(response)
    when 404 then nil
    end
  end

  def handle_successful_response(response)
    type = response.headers.fetch(:content_type, '')

    if %r{^text/html}.match?(type)
      handle_html_response(response)
    else
      feed_type = FeedType.by_mime_type(type)
      if feed_type
        feed_type.find(response)
      else
        Rails.logger.warn "Unexpected content type #{type}"
        nil
      end
    end
  end

  def handle_html_response(response)
    html = Nokogiri::HTML(response.body)
    feed = FeedType.prioritized.lazy.map { |t|
      html.css(%(link[rel=alternate][type="#{t.mime_type}"])).first
    }.detect(&:itself)
    attempt_url(feed['href']) if feed.present?
  end
end
