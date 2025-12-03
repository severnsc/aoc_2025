class ProductIdAggregator
  def initialize(validator_class)
    @validator_class = validator_class
  end

  def aggregate(ranges)
    sum = 0
    ranges.each do |range|
      validator = @validator_class.new range
      invalid_ids = validator.invalid_ids
      sum += invalid_ids.sum
    end

    sum
  end
end
