class ChangeBusinessTypeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :businesses, :type, :business_type
  end
end
