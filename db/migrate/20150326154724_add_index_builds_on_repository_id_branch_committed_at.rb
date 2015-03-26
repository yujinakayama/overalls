class AddIndexBuildsOnRepositoryIdBranchCommittedAt < ActiveRecord::Migration
  def change
    add_index :builds, [:repository_id, :branch, :committed_at]
  end
end
