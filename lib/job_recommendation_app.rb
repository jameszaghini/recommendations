# frozen_string_literal: true

require 'csv'
require 'json'

require_relative 'models/job'
require_relative 'models/job_seeker'
require_relative 'models/recommendation'
require_relative 'import_service'

# Finds the recommended jobs for a jobseeker
class JobRecommendationApp
  attr_reader :jobs, :job_seekers, :recommendations

  def initialize
    job_seeker_file_path = 'data/jobseekers.csv'
    job_file_path = 'data/jobs.csv'

    @job_seekers = ImportService.import_job_seekers(job_seeker_file_path)
    @jobs = ImportService.import_jobs(job_file_path)

    @recommendations = []

    find_matches
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

  def print_recommendations
    csv_string = CSV.generate do |csv|
      csv << csv_header

      recommendations.each do |rec|
        csv << [
          rec.jobseeker_id,
          rec.jobseeker_name,
          rec.job_id,
          rec.job_title,
          rec.matching_skill_count,
          rec.matching_skill_percent
        ]
      end
    end

    puts csv_string
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
