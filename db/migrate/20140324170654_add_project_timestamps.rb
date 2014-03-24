class AddProjectTimestamps < ActiveRecord::Migration
  def change
    add_timestamps (:projects)
  end
end
