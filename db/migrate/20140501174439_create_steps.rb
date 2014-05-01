class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :action
      t.string :target
      t.string :expects
      t.belongs_to :scenario, index: true

      t.timestamps
    end
  end
end
