class RiskScoring < ActiveRecord::Base
<<<<<<< HEAD
	
	belongs_to :scoring, :polymorphic => true

=======

	# Associations
	has_many :control_measure
>>>>>>> 72019b43f343ff81b7f400c0c7331dc84a20c1ef
end
