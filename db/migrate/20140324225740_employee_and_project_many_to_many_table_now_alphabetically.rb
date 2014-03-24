class EmployeeAndProjectManyToManyTableNowAlphabetically < ActiveRecord::Migration
  def change
    create_table :employees_projects do |t|
      t.belongs_to :projects
      t.belongs_to :employees
    end

    drop_table(:projects_employees)
  end
end
