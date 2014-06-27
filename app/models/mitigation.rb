class Mitigation < ActiveRecord::Base
  belongs_to :risk
  belongs_to :planning_strategy
  belongs_to :mitigation_effort
  belongs_to :submitor, :class_name => "User", foreign_key: :submitted_by
end
