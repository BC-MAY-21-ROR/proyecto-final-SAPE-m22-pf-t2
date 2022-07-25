class ChangeUserToOwnerForBusiness < ActiveRecord::Migration[7.0]
  def change
    rename_column :businesses, :user_id, :owner_id
  end
end
