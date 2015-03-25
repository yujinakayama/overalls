require 'rails_helper'

RSpec.describe TestReport do
  subject(:test_report) { build(:test_report) }

  it 'returns values for each data attribute' do
    expect(test_report).to respond_to(*test_report.keys)
  end

  describe '#data' do
    it 'returns decoded json data' do
      expect(test_report.data).to have_attributes(source_files: an_instance_of(Array))
    end
  end
end