class Metric
  AVAILABLE_CATEGORIES = [:activity, :social, :etiquette]

  # Override and return the metric's score, in the (1..100) range.
  # Must be integer.
  def score
    raise "Override and return the metric's score"
  end

  # Override and return the metric's categories. Has to be an array with one or
  # more symbols listed in AVAILABLE_CATEGORIES.
  def categories
    raise "Override and return the metric's categories"
  end

  # Override and return the metric's weight in in each category. Has to be an
  # array of the same size as that returned by categories, each weight in the
  # (1..10) range. Integers only.
  def categories_weights
    raise "Override and return the metric's weight in each category"
  end

  # Override and return the metric's expiration date. Take the time of
  # calculation, add the validity time, and return a Time object.
  def expires_at
    raise "Override and return the metric's expiration time"
  end
end
