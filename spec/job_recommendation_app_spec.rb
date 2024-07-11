# spec/job_recommendation_app_spec.rb

require 'job_recommendation_app'
require 'import_service'
require 'recommendation_exporter'
require 'recommendation_generator'

RSpec.describe JobRecommendationApp do
  let(:jobseekers) { [double('JobSeeker')] }
  let(:jobs) { [double('Job')] }
  let(:recommendations) { [double('Recommendation')] }

  before do
    allow(ImportService).to receive(:import_job_seekers).and_return(jobseekers)
    allow(ImportService).to receive(:import_jobs).and_return(jobs)
    allow(RecommendationGenerator).to receive(:new).with(jobseekers:, jobs:).and_return(double(run: recommendations))
    allow(RecommendationExporter).to receive(:new).with(recommendations:).and_return(double(export: nil))
  end

  describe '#initialize' do
    context 'when jobseekers are present' do
      it 'imports jobseekers' do
        expect(ImportService).to receive(:import_job_seekers)
        JobRecommendationApp.new
      end

      context 'when jobs are present' do
        it 'imports jobs' do
          expect(ImportService).to receive(:import_jobs)
          JobRecommendationApp.new
        end

        context 'when recommendations are present' do
          it 'generates recommendations' do
            expect(RecommendationGenerator).to receive(:new).with(jobseekers:, jobs:)
            JobRecommendationApp.new
          end

          it 'exports recommendations' do
            expect(RecommendationExporter).to receive(:new).with(recommendations:)
            JobRecommendationApp.new
          end
        end

        context 'when no recommendations are present' do
          let(:recommendations) { [] }

          it 'outputs "no recommendations"' do
            expect { JobRecommendationApp.new }.to output(/no recommendations/).to_stdout
          end
        end
      end

      context 'when no jobs are present' do
        let(:jobs) { [] }

        it 'outputs "no jobs"' do
          expect { JobRecommendationApp.new }.to output(/no jobs/).to_stdout
        end
      end
    end

    context 'when no jobseekers are present' do
      let(:jobseekers) { [] }

      it 'outputs "no jobseekers"' do
        expect { JobRecommendationApp.new }.to output(/no jobseekers/).to_stdout
      end
    end
  end

  describe '.run' do
    it 'creates a new instance of JobRecommendationApp' do
      expect(JobRecommendationApp).to receive(:new)
      JobRecommendationApp.run
    end
  end
end
