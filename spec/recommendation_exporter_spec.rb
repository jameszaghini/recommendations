# spec/recommendation_exporter_spec.rb

require 'recommendation_exporter'
require 'csv'

RSpec.describe RecommendationExporter do
  let(:recommendations) do
    [
      Recommendation.new(1, 'Software Engineer', 1, 'John Doe', 2, 50.0),
      Recommendation.new(2, 'Data Analyst', 2, 'Jane Smith', 3, 75.5)
    ]
  end

  subject(:exporter) { described_class.new(recommendations:) }

  describe '#export' do
    it 'generates correct CSV output' do
      expected_csv = <<~CSV
        jobseeker id,jobseeker name,job id,job title,matching skill count,matching skill percent
        1,John Doe,1,Software Engineer,2,50%
        2,Jane Smith,2,Data Analyst,3,76%
      CSV

      expect { exporter.export }.to output(expected_csv).to_stdout
    end
  end

  describe '#csv_row' do
    it 'returns a correct CSV row for a recommendation' do
      recommendation = recommendations.first
      csv_row = exporter.csv_row(recommendation:)
      expect(csv_row).to eq([1, 'John Doe', 1, 'Software Engineer', 2, '50%'])
    end
  end

  describe '#csv_header' do
    it 'returns the correct CSV header' do
      expect(exporter.csv_header).to eq([
                                          'jobseeker id',
                                          'jobseeker name',
                                          'job id',
                                          'job title',
                                          'matching skill count',
                                          'matching skill percent'
                                        ])
    end
  end
end
