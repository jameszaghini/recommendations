# frozen_string_literal: true

require 'json'

require_relative 'models/job'
require_relative 'models/job_seeker'
require_relative 'models/recommendation'
require_relative 'import_service'
require_relative 'recommendation_exporter'

# Finds the recommended jobs for a jobseeker
class JobRecommendationApp
  attr_reader :jobs, :job_seekers, :recommendations

  def initialize
    @job_seekers = ImportService.import_job_seekers
    @jobs = ImportService.import_jobs
    @recommendations = []

    find_matches

    RecommendationExporter.new(recommendations:).export
  end

  def self.run = new

  def find_matches
    job_seekers.each do |jobseeker|
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
