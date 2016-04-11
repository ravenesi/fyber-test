class ChangeMaintainersAndAuthorsUseJsonToPackages < ActiveRecord::Migration
  def change
    remove_column :packages, :maintainers
    add_column :packages, :maintainers, :json, default: []

    remove_column :packages, :authors
    add_column :packages, :authors, :json, default: []
  end
end
