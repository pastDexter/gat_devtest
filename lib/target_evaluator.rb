class TargetEvaluator

  attr_reader :pricing_logic, :locations

  def initialize(locations, pricing_logic)
    @pricing_logic = pricing_logic
    @locations = locations
  end

  def calculate_price
    pricing_logic.calculate(total_panel_size)
  end

  private

  def total_panel_size
    locations.reduce(0) { |sum, el| sum + el[:panel_size].to_i }
  end

end