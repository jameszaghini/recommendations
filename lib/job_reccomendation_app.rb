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
    new()
  end

  # The goal of the engine is to suggest jobs to jobseekers based on their skills and the required skills for each job.

  def find_matches
    job_seekers.each do |seeker|
      jobs.each do |job|
        matching_skills = seeker.skills & job.required_skills

        next unless matching_skills.any?

        reccomendations << Reccomendation.new(seeker.id, job.id, matching_skills.count)
      end
    end
  end

  # The output should be sorted first by jobseeker ID and then by the percentage of matching skills in descending order (so that jobs with the highest percentage of matching skills are listed first). If two jobs have the same matching skill percentage, they should be sorted by job ID in ascending order.

  # outputs a list of job recommendations for each jobseeker.
  # Each recommendation should include the jobseeker's ID, the job ID, and the number of matching skill
  def print_reccomendations
    csv_string = CSV.generate do |csv|
      csv << ["job seeker id", "job id", "matching skills count"]
      reccomendations.each do |rec|
        csv << rec.values
      end
    end

    puts csv_string
  end
end
