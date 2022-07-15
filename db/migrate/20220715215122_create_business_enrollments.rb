class CreateBusinessEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :business_enrollments do |t|
      t.belongs_to :user
      t.belongs_to :business
      t.integer :role, default: 0
      t.boolean :owner, default: false

      t.timestamps
    end
  end
end
