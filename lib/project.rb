class Project < ActiveRecord::Base
  has_and_belongs_to_many :employees

  def self.find_project(project_name)
    Project.where({:name => project_name}).first
  end
end
