class EmployeeAndProjectManyToManyTableDropEmployeesProjectsForReasonsOfImproperPluralizationAndGeneralMalaise < ActiveRecord::Migration
  def change
    drop_table(:employees_projects)

    create_table :projects_employees do |t|
      t.belongs_to :project
      t.belongs_to :employee
    end
  end
end
