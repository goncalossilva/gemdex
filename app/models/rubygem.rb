class Rubygem < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :metric_results

  def score_expired?
    queued || available_metrics.any?(&:expired?)
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
      delay.update_score
    end
  end

  private

  def available_metric_results
    # read the list of available metrics from configuration file
    configuration_file = File.join(Rails.root.to_s, 'config', 'metrics.yml')
    metric_classnames = YAML.load_file(configuration_file)['metrics_classnames']

    # create or drop objects appropriately
    current_names = metric_results.collect &:kind

    transaction do
      ## do we have any deprecated metric?
      deprecated_metric_results = current_names - metric_classnames
      deprecated_metric_results.each do |name|
        metric_results.where(kind: name).destroy_all
      end

      ## are we missing any metric?
      new_metric_results = metric_classnames - current_names
      new_metric_results.each do |name|
        metric_results.create kind: name
      end
    end

    # return the list of available metrics
    metric_results
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
