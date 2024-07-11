# spec/job_spec.rb

require 'models/job'

RSpec.describe Job do
  subject(:job) { Job.new(1, 'Software Engineer', %w[Ruby Rails]) }

  describe '#id' do
    it 'returns the job id' do
      expect(job.id).to eq(1)
    end
  end

  describe '#title' do
    it 'returns the job title' do
      expect(job.title).to eq('Software Engineer')
    end
  end

  describe '#required_skills' do
    it 'returns the required skills' do
      expect(job.required_skills).to eq(%w[Ruby Rails])
    end
  end
end