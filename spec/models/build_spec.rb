require 'rails_helper'

RSpec.describe Build do
  subject(:build_object) { test_report.build }
  let(:test_report) { create(:test_report) }

  describe '#completed?' do
    subject { build_object.completed? }

    context 'when the parallelism is 2' do
      before do
        build_object.parallelism = 2
      end

      context "and there's only 1 associated test report" do
        it { should be false }
      end

      context "and there're 2 associated test reports" do
        before do
          create(:test_report, build: build_object)
        end

        it { should be true }
      end
    end
  end

  context 'on completion' do
    before do
      create(:test_report, build: build_object)

      build_object.test_reports[0].data.source_files = [
        OpenStruct.new(line_counts: { total: 50, covered: 27, missed: 1 })
      ]

      build_object.test_reports[1].data.source_files = [
        OpenStruct.new(line_counts: { total: 583, covered: 313, missed: 9 })
      ]
    end

    it 'sets #covered_percent' do
      expect(build_object.covered_percent).to be_within(0.01).of(97.20)
    end
  end
end
