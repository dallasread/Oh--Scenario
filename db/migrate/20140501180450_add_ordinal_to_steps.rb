class AddOrdinalToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :ordinal, :integer
  end
end
