require 'rails_helper'

RSpec.describe Repository do
  subject(:repository) { create(:repository) }

  context 'on creation' do
    it 'assigns unique token' do
      expect(repository.token.size).to eq(64)
      expect(repository.token).to match(/^[0-9a-f]+$/)
    end
  end
end
