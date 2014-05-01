class AddUserToWebsites < ActiveRecord::Migration
  def change
    add_reference :websites, :user, index: true
  end
end
