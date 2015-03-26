class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.integer :repository_id, null: false
      t.string :name, null: false
      t.string :branch, null: false
      t.integer :parallelism, null: false
      t.datetime :committed_at, null: false
      t.timestamps null: false

      t.index [:repository_id, :name]
    end

    change_table :test_reports do |t|
      t.integer :build_id, after: :repository_id
      t.remove :repository_id
      t.remove :branch
      t.remove :committed_at

      t.index :build_id
    end
  end
end
