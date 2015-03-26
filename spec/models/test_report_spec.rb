require 'rails_helper'

RSpec.describe TestReport do
  subject(:test_report) { build(:test_report) }

  it 'returns values for each data attribute except `partial`' do
    attributes = test_report.keys - [:partial]
    expect(test_report).to respond_to(*attributes)
  end

  describe '#data' do
    it 'returns decoded json data' do
      expect(test_report.data).to have_attributes(source_files: an_instance_of(Array))
    end
  end

  describe '#source_files' do
    it 'does not have `coverage` attribute to reduce the data size' do
      expect(test_report.source_files).to all satisfy { |file| file.coverage.nil? }
    end
  end

  shared_examples 'with `partial` value' do |data_value, expected|
    context "and `partial` value in json is #{data_value}" do
      before do
        test_report.data.partial = data_value
      end

      it { should be expected }
    end
  end

  describe 'partial?' do
    subject { test_report.partial? }

    shared_examples 'with `partial` value' do |data_value, expectation|
      context "and `partial` value in json is #{data_value}" do
        before do
          test_report.data.partial = data_value
        end

        it { should be expectation[:expect] }
      end
    end

    context 'when `ci_service.node_total` is not set' do
      before do
        test_report.ci_service.delete_field(:node_total)
      end

      include_examples 'with `partial` value', true,  expect: true
      include_examples 'with `partial` value', false, expect: false
    end

    context 'when `ci_service.node_total` value is 1' do
      before do
        test_report.ci_service.node_total = 1
      end

      include_examples 'with `partial` value', true,  expect: true
      include_examples 'with `partial` value', false, expect: false
    end

    context 'when `ci_service.node_total` value is larger than 1' do
      before do
        test_report.ci_service.node_total = 2
      end

      include_examples 'with `partial` value', true,  expect: true
      include_examples 'with `partial` value', false, expect: true
    end
  end
end
