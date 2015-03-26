class AddMainBranchToRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :main_branch, :string, after: :namespace
  end
end
