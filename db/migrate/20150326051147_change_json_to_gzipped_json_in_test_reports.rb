class ChangeJsonToGzippedJsonInTestReports < ActiveRecord::Migration
  def change
    change_table :test_reports do |t|
      t.remove :json
      t.binary :gzipped_json, limit: 65_535
    end
  end
end
