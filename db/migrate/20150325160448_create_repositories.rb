class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :name, null: false
      t.string :namespace, null: false
      t.string :token, limit: 64, null: false
      t.timestamps null: false

      t.index :token, unique: true
    end
  end
end
