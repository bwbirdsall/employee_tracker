require 'spec_helper'

describe Employee do
  it { should have_many :projects}

  describe 'Employee.division_list(division)' do
    it 'returns the employees within a specific division' do
      articulated_bird_skeleton_mobiles = Division.new(:name => 'articulated bird skeletons')
      articulated_bird_skeleton_mobiles.save
      bird_worker = Employee.new(:name => "Tara Nelson", :division_id => articulated_bird_skeleton_mobiles.id)
      bird_worker.save
      elephant_worker = Employee.new(:name => "Ben Birdsall")
      elephant_worker.save
      Employee.division_list('articulated bird skeletons').should eq [bird_worker]
    end
  end
end
