# frozen_string_literal: true

require 'csv'
require 'json'

require_relative 'models/job'
require_relative 'models/job-seeker'
require_relative 'models/reccomendation'
require_relative 'import_service'

class JobReccomendationApp
  attr_reader :jobs, :job_seekers, :reccomendations

  def initialize
    job_seeker_file_path = 'data/jobseekers.csv'
    job_file_path = 'data/jobs.csv'

    @job_seekers = ImportService.import_job_seekers(job_seeker_file_path)
    @jobs = ImportService.import_jobs(job_file_path)

    @reccomendations = []

    find_matches
    print_reccomendations
  end

  def self.run
    new
  end

  # The goal of the engine is to suggest jobs to jobseekers based on their skills and the required skills for each job.

  def find_matches
    job_seekers.each do |jobseeker|
      jobs.each do |job|
        matching_skills = jobseeker.skills & job.required_skills

        next unless matching_skills.any?

        reccomendations << Reccomendation.new(jobseeker.id, jobseeker.name, job.id, job.title, matching_skills.count,
                                              matching_skills.count)
      end
    end
  end

  def print_reccomendations
    csv_string = CSV.generate do |csv|
      csv << csv_header

      reccomendations.each do |rec|
        csv << [rec.jobseeker_id, rec.jobseeker_name, rec.job_id, rec.job_title, rec.matching_skill_count,
                rec.matching_skill_percent]
      end
    end

    puts csv_string
  end

  def csv_header = ['jobseeker id', 'jobseeker name', 'job id', 'job title', 'matching skill count',
                    'matching skill percent']
end
