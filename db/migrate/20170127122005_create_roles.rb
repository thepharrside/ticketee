class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.references :user, foreign_key: true
      t.string :role
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
