class AddCoveredPercentToBuilds < ActiveRecord::Migration
  def change
    add_column :builds, :covered_percent, :float, after: :parallelism
  end
end
