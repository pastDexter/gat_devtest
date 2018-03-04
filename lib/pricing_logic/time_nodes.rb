require 'nokogiri'

module PricingLogic
  class TimeNodes < Web
    URL = 'http://time.com'

    protected

    def fetch_multiplying_factor
      parsed_homepage = Nokogiri::HTML(fetch_url(URL))
      parsed_homepage.css('*').count / 100.0
    end

  end
end