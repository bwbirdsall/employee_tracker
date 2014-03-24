class EmployeeAndProjectManyToManyTableDropEmployeesProjectsForReasonsOfAlphabeticalOrderAgain < ActiveRecord::Migration
  def change
    drop_table(:projects_employees)

    create_table :employees_projects do |t|
      t.belongs_to :project
      t.belongs_to :employee
    end
  end
end
