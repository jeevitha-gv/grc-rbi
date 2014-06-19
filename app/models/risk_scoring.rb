class RiskScoring < ActiveRecord::Base
	
	belongs_to :scoring, :polymorphic => true

end
