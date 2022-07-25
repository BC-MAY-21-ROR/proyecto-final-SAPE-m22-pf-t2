class RemoveOwnerFromBusinessEnrollments < ActiveRecord::Migration[7.0]
  def change
    remove_column :business_enrollments, :owner
  end
end
