class ProductIdAggregator
  def aggregate(ranges)
    sum = 0
    ranges.each do |range|
      validator = ProductIdValidator.new range
      invalid_ids = validator.invalid_ids
      sum += invalid_ids.sum
    end

    sum
  end
end
