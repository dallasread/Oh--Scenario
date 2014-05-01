class AddWebsiteToScenario < ActiveRecord::Migration
  def change
    add_reference :scenarios, :website, index: true
  end
end
