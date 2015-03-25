class Repository < ActiveRecord::Base
  has_many :test_reports, dependent: :destroy

  validates :name, presence: true
  validates :namespace, presence: true
  validates :token, presence: true, length: { is: 64 }

  after_initialize do
    self.token ||= SecureRandom.hex(32)
  end
end