# frozen_string_literal: true

require_relative 'models/job_seeker'
require_relative 'models/job'
require 'pathname'

class ImportService
  def self.import_job_seekers(file_path: "#{Pathname.pwd}/data/jobseekers.csv")
    job_seekers = []
    begin
      CSV.foreach(file_path, headers: true) do |row|
        id = row['id'].to_i
        name = row['name']
        skills = row['skills'].split(', ').map(&:strip)
        job_seekers << JobSeeker.new(id, name, skills)
      end
    rescue Errno::ENOENT => e
      puts "File not found: #{e.message}"
    end
    job_seekers
  end

  def self.import_jobs(file_path: "#{Pathname.pwd}/data/jobs.csv")
    jobs = []
    begin
      CSV.foreach(file_path, headers: true) do |row|
        id = row['id'].to_i
        title = row['title']
        required_skills = row['required_skills'].split(', ').map(&:strip)
        jobs << Job.new(id, title, required_skills)
      end
    rescue Errno::ENOENT => e
      puts "File not found: #{e.message}"
    end
    jobs
  end
end
