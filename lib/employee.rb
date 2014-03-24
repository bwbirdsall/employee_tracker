class Employee < ActiveRecord::Base
  belongs_to :division
  has_and_belongs_to_many :projects

  def self.division_list(division_name)
    division = Division.find_division(division_name)
    where({ :division_id => division.id})
  end

  def self.find_employee(employee_name)
    Employee.where({:name => employee_name}).first
  end
end
