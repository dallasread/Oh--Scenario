class AddDefaultUrlToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :default_url, :string
  end
end
