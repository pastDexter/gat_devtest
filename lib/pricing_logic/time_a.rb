require 'nokogiri'
require 'open-uri'

module PricingLogic
  class TimeA < Web
    URL = 'http://time.com'

    protected

    def fetch_multiplying_factor
      time_homepage = fetch_url(URL)
      time_homepage.count('a') / 100.0
    end

  end
end