module PricingLogic
  class Base

    def calculate(panel_size)
      panel_size * factor
    end

    protected

    def factor
      @_factor ||= fetch_multiplying_factor.to_f
    end

    def fetch_multiplying_factor
      raise NotImplementedError
    end

  end
end