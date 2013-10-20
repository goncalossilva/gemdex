class Metric
  AVAILABLE_CATEGORIES = [:activity, :social, :etiquette]

  SINCE_DATE = 1.year.ago
  RECENT_SINCE_DATE = 2.months.ago

  def initialize(metadata)
    @metadata = metadata
  end

  def score
    [0, [10, get_score].min].max
  end

  # Override and return the metric's score, in the (0..100) range.
  # Must be integer.
  def calculate_score
    raise "Override and return the metric's score"
  end

  # Override and return the metric's weight in the specified category. Has to
  # Must return an integer in the (0..10) range.
  def weight(category)
    raise "Override and return the metric's weight in the specified category"
  end

  # Override and return the metric's expiration date. Take the time of
  # the call, add the validity time, and return a Time object.
  def expires_at
    raise "Override and return the metric's expiration time"
  end

end
