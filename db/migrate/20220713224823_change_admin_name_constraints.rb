class ChangeAdminNameConstraints < ActiveRecord::Migration[7.0]
  def change
    change_column_null :admins, :name, false
  end
end
