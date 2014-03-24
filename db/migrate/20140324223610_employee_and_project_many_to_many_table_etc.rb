class EmployeeAndProjectManyToManyTableEtc < ActiveRecord::Migration
  def change
    remove_column :projects, :employee_id, :integer

    create_table :projects_employees do |t|
      t.belongs_to :projects
      t.belongs_to :employees
    end
  end
end
