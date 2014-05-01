class AddLatestResultToScenario < ActiveRecord::Migration
  def change
    add_column :scenarios, :latest_result, :boolean, default: false
    add_column :scenarios, :latest_result_at, :datetime
  end
end
