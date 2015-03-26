require 'rails_helper'

RSpec.describe TestReport do
  subject(:test_report) { build(:test_report) }

  it 'returns values for each data attribute except `partial`' do
    attributes = test_report.keys - [:partial]
    expect(test_report).to respond_to(*attributes)
  end

  context 'on creation' do
    subject(:new_test_report) { build(:test_report) }

    context 'when no corresponding build exists' do
      it 'creates a build and associates itself with the build' do
        expect { new_test_report.save }
          .to change { new_test_report.build }.from(nil).to(an_instance_of(Build))
          .and change { Build.count }.by(1)
      end
    end

    context 'when another build for the same repository exists' do
      before do
        create(:build, repository: new_test_report.repository, name: 'another_build')
      end

      it 'creates a build and associates itself with the build' do
        expect { new_test_report.save }
          .to change { new_test_report.build }.from(nil).to(an_instance_of(Build))
          .and change { Build.count }.by(1)
      end
    end

    context 'when a same name build for another repository exists' do
      before do
        create(:build, name: new_test_report.build_name)
      end

      it 'creates a build and associates itself with the build' do
        expect { new_test_report.save }
          .to change { new_test_report.build }.from(nil).to(an_instance_of(Build))
          .and change { Build.count }.by(1)
      end
    end

    context 'when a corresponding build exists' do
      before do
        create(:build, repository: new_test_report.repository, name: new_test_report.build_name)
      end

      it 'associates itself with the build without creating new one' do
        expect { new_test_report.save }
          .to change { new_test_report.build }.from(nil).to(an_instance_of(Build))
          .and change { Build.count }.by(0)
      end
    end
  end

  describe '#data' do
    it 'returns decoded json data' do
      expect(test_report.data).to have_attributes(source_files: an_instance_of(Array))
    end
  end

  describe '#build_name' do
    context 'when `ci_service.name` and `ci_service.build_identifier` are set' do
      before do
        test_report.ci_service.name = 'circleci'
        test_report.ci_service.build_identifier = '12345'
      end

      it 'returns a name consist of them' do
        expect(test_report.build_name).to eq('circleci-12345')
      end
    end

    context 'when `ci_service.name` and `ci_service.build_identifier` are not set' do
      before do
        test_report.data.ci_service = OpenStruct.new
      end

      it 'returns a name consist of "local" and time from `git.committed_at`' do
        expect(test_report.build_name).to start_with('local-').and match('-\d{8}_\d{6}$')
      end
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
