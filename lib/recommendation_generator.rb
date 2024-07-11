# frozen_string_literal: true

class RecommendationGenerator
  attr_reader :jobseekers, :jobs, :recommendations

  def initialize(jobseekers:, jobs:)
    @jobseekers = jobseekers
    @jobs = jobs
    @recommendations = []
  end

  def run
    generate_recommendations
    recommendations
  end

  def generate_recommendations
    jobseekers.each do |jobseeker|
      jobs.each do |job|
        matching_skills = match_skills_for(jobseeker:, job:)

        next if matching_skills.none?

        add_recommendation(jobseeker:, job:, matching_skills:)
      end
    end
  end

  def match_skills_for(jobseeker:, job:) = jobseeker.skills & job.required_skills

  def add_recommendation(jobseeker:, job:, matching_skills:)
    recommendations << Recommendation.new(
      jobseeker.id,
      jobseeker.name,
      job.id,
      job.title,
      matching_skills.count,
      matching_skills.count # TODO: This should be percentage
    )
  end
end
