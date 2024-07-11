# frozen_string_literal: true

require_relative 'import_service'
require_relative 'recommendation_exporter'
require_relative 'recommendation_generator'

# Finds the recommended jobs for a jobseeker
class JobRecommendationApp
  def initialize
    jobseekers = ImportService.import_job_seekers
    puts 'no jobseekers' and return if jobseekers.empty?

    jobs = ImportService.import_jobs
    puts 'no jobs' and return if jobs.empty?

    recommendations = RecommendationGenerator.new(jobseekers:, jobs:).run
    puts 'no recommendations' and return if recommendations.empty?

    RecommendationExporter.new(recommendations:).export
  end

  def self.run = new
end
