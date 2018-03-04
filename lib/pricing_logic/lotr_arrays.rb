require 'json'

module PricingLogic
  class LotrArrays < Web
    URL = 'http://openlibrary.org/search.json?q=the+lord+of+the+rings'
    MIN_LENGTH = 10

    protected

    def fetch_multiplying_factor
      json = JSON.parse(fetch_url(URL))
      count_arrays(json)
    end

    def count_arrays(object)
      count = 0
      case object
      when Array
        count += 1 if object.length > MIN_LENGTH
        object.each       { |o| count += count_arrays(o) }
      when Hash
        object.each_value { |o| count += count_arrays(o) }
      end
      count
    end

  end
end
