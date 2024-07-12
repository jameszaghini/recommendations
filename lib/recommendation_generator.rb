# frozen_string_literal: true

require_relative 'percentage_helper'
require_relative 'models/recommendation'

class RecommendationGenerator
  include PercentageHelper

  attr_reader :jobseekers, :jobs, :recommendations

  def initialize(jobseekers:, jobs:)
    @jobseekers = jobseekers.sort_by(&:id)
    @jobs = jobs
    @recommendations = []
  end

  def run
    generate_recommendations
    recommendations
  end

  private

  def generate_recommendations
    jobseekers.each do |jobseeker|
      jobs.each do |job|
        matching_skills = match_skills_for(jobseeker:, job:)

        next if matching_skills.none?

        matching_skills_percentage = calculate_percentage(matching_skills.count, jobseeker.skills.count)

        add_recommendation(jobseeker:, job:, matching_skills:, matching_skills_percentage:)
      end
    end
  end

  def match_skills_for(jobseeker:, job:) = jobseeker.skills & job.required_skills

  def add_recommendation(jobseeker:, job:, matching_skills:, matching_skills_percentage:)
    recommendations << Recommendation.new(
      jobseeker.id,
      jobseeker.name,
      job.id,
      job.title,
      matching_skills.count,
      matching_skills_percentage.round
    )
  end
end
