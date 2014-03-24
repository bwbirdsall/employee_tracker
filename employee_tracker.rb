require 'active_record'
require './lib/employee'
require './lib/project'
require './lib/division'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  system('clear')
  puts "===============Hurray, You Are Employed===============\n\n\n\n"
  menu
end

def menu
  choice = nil
  until choice == 'q'
    puts "Press 'e' to add an employee."
    puts "Press 'd' to add a division."
    puts "Press 'p' to add a project."
    puts "Press 'le' to list all employees."
    puts "Press 'ld' to list all divisions."
    puts "Press 'lp' to list all projects."
    puts "Press 'q' to quit."
    choice = gets.chomp
    case choice
    when 'e'
      add_employee
    when 'd'
      add_division
    when 'p'
      add_project
    when 'le'
      list_employees
    when 'ld'
      list_divisions
    when 'lp'
      list_projects
    when 'q'
      puts "Fare thee well."
      exit
    else
      puts "I'm not sorry, but that is not a valid option."
    end
  end
end

def add_employee
  puts "\nPlease enter the employee's first and last name: "
  name = gets.chomp
  employee = Employee.new({:name => name})
  employee.save
  puts "'#{employee.name}' has been added to the database.\n\n"
  assign_division(employee)
end

def assign_division(employee)
  puts "Please enter the division name for #{employee.name}: "
  division_name = gets.chomp
  division = Division.find_division(division_name)
  if division == nil
    puts "#{division_name} does not exist. Would you like to add it? (y/n)"
    choice = gets.chomp
    if choice == 'y'
      division = add_division(division_name)
    else
      assign_division(employee)
    end
  end
  division.employees << employee
end

def add_division(name = nil)
  if name.nil?
    puts "\nPlease enter the division:"
    name = gets.chomp
  end
  division = Division.new({:name => name})
  division.save
  puts "'#{division.name}' has been added to the database.\n\n"
  division
end

def add_project
  puts "\nPlease enter the project's name:"
  name = gets.chomp
  project = Project.new({:name => name, :done => false})
  project.save
  "'#{project.name}' has been saved to the database.\n\n"
  puts "What employee should #{project.name} be assigned to?"
  employee_name = gets.chomp
  until Employee.find_employee(employee_name) != nil
    puts "That is not a valid employee. Enter 'l' to list employees, or have another go at properly entering an employee's name."
    bad_job_choice = gets.chomp
    if bad_job_choice == 'l'
      list_employees
      puts "Enter the name of the employee you wish to assign #{project.name} to."
      employee_name = gets.chomp
    else
      employee_name = bad_job_choice
    end
  end
  employee = Employee.find_employee(employee_name)
  employee.projects << project
end

def list_employees
  puts "\nHere are all of the employees:"
  employees = Employee.all
  employees.each { |employee| puts employee.name }
  puts "\n\n"
end

def list_divisions
  puts "\nHere are all of the divisions:"
  divisions = Division.all
  divisions.each { |division| puts division.name }
  puts "\nEnter a division name to see the list of employees in that division."
  puts "Enter 'm' to return to the main menu."
  div_choice = nil
  div_choice = gets.chomp
  if div_choice == 'm'
    menu
  elsif Division.find_division(div_choice).nil?
    puts "That is not a valid division. Please try again."
    list_divisions
  else
    employees = Employee.division_list(div_choice)
    puts
    employees.each { |employee| puts employee.name }
    gets
    div_choice = 'm'
    puts "\n\n"
  end
end

def list_projects
  puts "\nHere are all of the projects:"
  projects = Project.all
  projects.each { |project| puts project.name }
  puts "\n\n"
  choice = nil
  until choice == 'c'
    puts "If you would like to mark a project as done press 'd' otherwise press 'c' to continue."
    choice = gets.chomp
    if choice == 'd'
      mark_project_done
    end
  end
end

def mark_project_done
  puts "Enter the name of the project to mark done."
  project_name = gets.chomp
  until Project.find_project(project_name) != nil
    puts "That is not a valid project name, please try again."
    project_name = gets.chomp
  end
  project = Project.find_project(project_name)
  project.update({:done => true})
  puts "#{project.name} has been marked done.\n\n"
end

welcome
