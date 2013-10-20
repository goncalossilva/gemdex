class Rubygem < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :scores

  def score_expired?
    queued || available_metrics.any? &:expired?
  end

  def score
    {
      karma: karma,
      categories_karma: {
        # TODO add categories
        activity: 0,
        social: 0,
        etiquette: 0
      }
    }
  end

  def refresh_score
    unless queued
      update_attribute :queued, true
      update_score.delay
    end
  end

  private
  def available_metrics
    # TODO
    # read the list of available metrics

    # create or drop objects appropriately

    # return the list of available metrics
  end

  def update_score
    # gather scores from different metrics
    scores = @available_metrics.collect &:score

    # set average score
    # TODO we should really set a real value
    # TODO we should really set a real value for categories
    update_attribute :karma, 10

    # reset status
    update_attribute :queued, false
  end

end
