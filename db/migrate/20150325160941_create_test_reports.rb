class CreateTestReports < ActiveRecord::Migration
  def change
    create_table :test_reports do |t|
      t.integer :repository_id, null: false
      t.string :branch, null: false
      t.float :covered_percent, null: false
      t.text :json, null: false
      t.datetime :committed_at, null: false
      t.datetime :run_at, null: false
      t.datetime :created_at, null: false

      t.index :repository_id
    end
  end
end
