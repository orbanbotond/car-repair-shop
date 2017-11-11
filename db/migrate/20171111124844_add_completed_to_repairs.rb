class AddCompletedToRepairs < ActiveRecord::Migration[5.1]
  def change
    add_column :repairs, :completed, :boolean
  end
end
