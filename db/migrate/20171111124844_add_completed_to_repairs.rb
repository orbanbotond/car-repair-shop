class AddCompletedToRepairs < ActiveRecord::Migration[5.1]
  def change
    add_column :repairs, :completed, :boolean, default: false
  end
end
