class Division < ActiveRecord::Base
  has_many :employees

  def self.find_division(division_name)
    Division.where({:name => division_name}).first
  end
end
