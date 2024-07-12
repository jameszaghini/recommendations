# frozen_string_literal: true

require 'csv'
require_relative 'models/recommendation'

# Exports an array of Recommendations to CSV
class RecommendationExporter
  attr_reader :recommendations

  def initialize(recommendations:)
    @recommendations = recommendations
  end

  def export
    csv_string = CSV.generate do |csv|
      csv << csv_header

      sorted_recommendations.each do |recommendation|
        csv << csv_row(recommendation:)
      end
    end

    puts csv_string
  end

  def sorted_recommendations
    recommendations.sort_by do
      [
        _1.jobseeker_id,            # sort by jobseeker id ascending
        -_1.matching_skill_percent  # then, matching skill percentage descending
      ]
    end
  end

  def csv_row(recommendation:)
    [
      recommendation.jobseeker_id,
      recommendation.jobseeker_name,
      recommendation.job_id,
      recommendation.job_title,
      recommendation.matching_skill_count,
      "#{recommendation.matching_skill_percent.round}%"
    ]
  end

  def csv_header = [
    'jobseeker id',
    'jobseeker name',
    'job id',
    'job title',
    'matching skill count',
    'matching skill percent'
  ]
end
