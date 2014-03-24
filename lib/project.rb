class Project < ActiveRecord::Base
  belongs_to :employee

  def self.find_project(project_name)
    Project.where({:name => project_name}).first
  end
end
