module PricingLogic
  class Web < Base

    protected

    def fetch_url(url)
      Rails.cache.fetch(url, expires_in: 1.minute) { open(url).read }
    rescue SocketError, OpenURI::HTTPError
      Rails.cache.fetch(url)
    end

    def parsed_html(url)
      @_parsed_html = Nokogiri::HTML(fetch_url(url))
    end

  end
end