class ActivitiesController < ApplicationController

  helper_method :parse_and_convert
 
 # List all activity performed
  def index
   @activities = PublicActivity::Activity.all
  end

# Parse the activity text for displaying
  def parse_and_convert(text)
  	thing = text.slice(0..(text.index('.')-1))
    (action = (text.slice((text.index('.')+1)..(text.length)))) == "destroy" ? action<<'ed' : action<<'d'
  	activity = action + " a " + thing + " at "
    return activity
  end
  
end
