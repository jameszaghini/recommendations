# spec/import_service_spec.rb

require 'import_service'
require 'csv'

RSpec.describe ImportService do
  let(:jobseekers_csv) { 'spec/fixtures/jobseekers.csv' }
  let(:jobs_csv) { 'spec/fixtures/jobs.csv' }

  describe '.import_job_seekers' do
    context 'when importing job seekers from CSV' do
      it 'imports job seekers correctly' do
        allow(CSV).to receive(:foreach).with(jobseekers_csv, headers: true).and_yield({'id' => '1', 'name' => 'John Doe', 'skills' => 'Ruby, Python'})
        job_seekers = ImportService.import_job_seekers(file_path: jobseekers_csv)
        expect(job_seekers.length).to eq(1)
        expect(job_seekers.first.id).to eq(1)
        expect(job_seekers.first.name).to eq('John Doe')
        expect(job_seekers.first.skills).to eq(%w[Ruby Python])
      end
    end
  end

  describe '.import_jobs' do
    context 'when importing jobs from CSV' do
      it 'imports jobs correctly' do
        allow(CSV).to receive(:foreach).with(jobs_csv, headers: true).and_yield({'id' => '1', 'title' => 'Software Engineer', 'required_skills' => 'Ruby, Rails'})
        jobs = ImportService.import_jobs(file_path: jobs_csv)
        expect(jobs.length).to eq(1)
        expect(jobs.first.id).to eq(1)
        expect(jobs.first.title).to eq('Software Engineer')
        expect(jobs.first.required_skills).to eq(%w[Ruby Rails])
      end
    end
  end
end