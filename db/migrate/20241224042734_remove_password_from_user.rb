class RemovePasswordFromUser < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :password
  end
end
