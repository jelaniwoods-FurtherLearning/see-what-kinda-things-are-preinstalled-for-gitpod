class ChangeOwnerToUserId < ActiveRecord::Migration[6.0]
  def change
    change_column :photos, :owner, :integer
  end
end
