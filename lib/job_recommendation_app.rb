# frozen_string_literal: true

require_relative 'import_service'
require_relative 'recommendation_exporter'
require_relative 'recommendation_generator'

# Finds the recommended jobs for a jobseeker
class JobRecommendationApp
  def initialize
    jobseekers = ImportService.import_job_seekers
    if jobseekers.empty?
      puts 'no jobseekers found'
      return
    end

    jobs = ImportService.import_jobs
    if jobs.empty?
      puts 'no jobs found'
      return if jobs.empty?
    end

    recommendations = RecommendationGenerator.new(jobseekers:, jobs:).run
    if recommendations.empty?
      puts 'no recommendations made'
      return if recommendations.empty?
    end

    RecommendationExporter.new(recommendations:).export
  end

  def self.run = new
end
