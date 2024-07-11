# frozen_string_literal: true

require 'json'

require_relative 'models/job'
require_relative 'models/job_seeker'
require_relative 'import_service'
require_relative 'recommendation_exporter'
require_relative 'recommendation_generator'

# Finds the recommended jobs for a jobseeker
class JobRecommendationApp
  def initialize
    jobseekers = ImportService.import_job_seekers
    jobs = ImportService.import_jobs

    recommendations = RecommendationGenerator.new(jobseekers:, jobs:).run

    RecommendationExporter.new(recommendations:).export
  end

  def self.run = new
end
