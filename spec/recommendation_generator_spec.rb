# spec/recommendation_generator_spec.rb

require 'recommendation_generator'
require 'models/job_seeker'
require 'models/job'

RSpec.describe RecommendationGenerator do
  let(:jobseekers) do
    [
      JobSeeker.new(1, 'John Doe', %w[Ruby Rails Python]),
      JobSeeker.new(2, 'Jane Smith', %w[Java C++]),
    ]
  end

  let(:jobs) do
    [
      Job.new(1, 'Software Engineer', %w[Ruby Rails]),
      Job.new(2, 'Data Analyst', %w[Python SQL]),
    ]
  end

  subject(:generator) { described_class.new(jobseekers:, jobs:) }

  describe '#run' do
    it 'generates recommendations correctly' do
      recommendations = generator.run
      expect(recommendations.length).to eq(2)
    end

    it 'includes correct recommendation details' do
      recommendations = generator.run
      expect(recommendations.map(&:jobseeker_id)).to match_array([1, 1])
      expect(recommendations.map(&:job_id)).to match_array([1, 2])
      expect(recommendations.map(&:matching_skill_count)).to match_array([1, 2])
    end
  end
end
