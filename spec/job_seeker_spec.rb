# spec/job_seeker_spec.rb

require 'models/job_seeker'

RSpec.describe JobSeeker do
  subject(:job_seeker) { JobSeeker.new(1, 'John Doe', %w[Ruby Python]) }

  describe '#id' do
    it 'returns the job seeker id' do
      expect(job_seeker.id).to eq(1)
    end
  end

  describe '#name' do
    it 'returns the job seeker name' do
      expect(job_seeker.name).to eq('John Doe')
    end
  end

  describe '#skills' do
    it 'returns the job seeker skills' do
      expect(job_seeker.skills).to eq(%w[Ruby Python])
    end
  end
end