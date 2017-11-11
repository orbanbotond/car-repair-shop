class AddApprovedToRepairs < ActiveRecord::Migration[5.1]
  def change
    add_column :repairs, :approved, :boolean, default: false
  end
end
