class MetricResult < ActiveRecord::Base
  belongs_to :rubygem

  def expired?
    DateTime.now > expires_at
  end

  def score
    if expired?
      # get the metric score for this gem
      score = metric.score

      # update status
      update_attribute :result, score
      update_attribute :expires_at, metric.expires_at

      # return the score
      metric.score
    else
      result
    end
  end

  def weight category
    metric.weight category
  end

  private

  def metric
    @metric ||= kind.constantize.new rubygem.metadata
  end
end
