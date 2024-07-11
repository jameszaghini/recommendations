# frozen_string_literal: true

module PercentageHelper
  def calculate_percentage(numerator, denominator)
    return 0 if denominator.zero?

    (numerator.to_f / denominator) * 100
  end
end
