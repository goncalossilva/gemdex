class Rubygem < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  serialize :categories_karma

  has_many :metric_results

  def score_expired?
    queued || available_metrics.any?(&:expired?)
  end

  def score
    {
      karma: karma,
      categories_karma: {
        activity: activity_karma,
        social: social_karma,
        etiquette: etiquette_karma
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
    categories = Metric.AVAILABLE_CATEGORIES
    category_maximum_score = Hash.new(0)
    category_scores = Hash.new(0)
    categories_karma = Hash.new(0)

    categories.each do |category|
      available_metric_results.each do |metric|
        category_maximum_score[category] += metric.weight(category) * 10
      end
    end

    categories.each do |category|
      available_metric_results.each do |metric|
        category_scores[category] += metric.weight(category) * metric.score
      end
    end

    categories.each do |category|
      categories_karma += category_scores[category] / category_maximum_score[category].to_f * 100
    end


    # set average karma
    transaction do
      update_attribute :karma, (categories_karma.values.inject(:+) / categories_karma.length)
      update_attribute :categories_karma, categories_karma
    end

    # reset status
    update_attribute :queued, false
  end

end
