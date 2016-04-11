class AddStatusToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :status, :integer, default: 0
  end
end
