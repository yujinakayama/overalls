require 'rails_helper'

RSpec.describe Build do
  subject(:build_object) { create(:test_report).build }

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
end
