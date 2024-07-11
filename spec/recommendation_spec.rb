# spec/recommendation_spec.rb

RSpec.describe Recommendation do
  subject(:recommendation) do
    Recommendation.new(
      1,
      'Software Engineer',
      1,
      'John Doe',
      2,
      50.0
    )
  end

  describe '#job_id' do
    it 'returns the recommendation job id' do
      expect(recommendation.job_id).to eq(1)
    end
  end

  describe '#job_title' do
    it 'returns the recommendation job title' do
      expect(recommendation.job_title).to eq('Software Engineer')
    end
  end

  describe '#jobseeker_id' do
    it 'returns the recommendation jobseeker id' do
      expect(recommendation.jobseeker_id).to eq(1)
    end
  end

  describe '#jobseeker_name' do
    it 'returns the recommendation jobseeker name' do
      expect(recommendation.jobseeker_name).to eq('John Doe')
    end
  end

  describe '#matching_skill_count' do
    it 'returns the recommendation matching skill count' do
      expect(recommendation.matching_skill_count).to eq(2)
    end
  end

  describe '#matching_skill_percent' do
    it 'returns the recommendation matching skill percent' do
      expect(recommendation.matching_skill_percent).to eq(50.0)
    end
  end
end