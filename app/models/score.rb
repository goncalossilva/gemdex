class Score < ActiveRecord::Base
  belongs_to :rubygem

  def expired?
    DateTime.now > expires_at
  end

  def score
    if expired?
      # get a metric instance and its score for this gem
      metric = kind.constantize.new rubygem.metadata
      score = metric.score

      # update status
      update_attribute :result, score
      update_attribute :expires_at, DateTime.now + metric.expires_at

      # return the score
      metric.score
    else
      result
    end
  end
end
