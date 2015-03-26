class Repository < ActiveRecord::Base
  has_many :builds, dependent: :destroy

  validates :name, presence: true
  validates :namespace, presence: true
  validates :main_branch, presence: true
  validates :token, presence: true, length: { is: 64 }

  after_initialize do
    self.main_branch ||= 'master'
    self.token ||= SecureRandom.hex(32)
  end

  def main_branch_builds
    builds.where(branch: main_branch)
  end
end
