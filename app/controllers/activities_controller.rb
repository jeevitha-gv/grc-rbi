class ActivitiesController < ApplicationController

  helper_method :parse_and_convert
 
  def index
   @activities = PublicActivity::Activity.all
  end

  def parse_and_convert(text)
  	thing = text.slice(0..(text.index('.')-1))
  	# action = text.slice((text.index('.')+1)..(text.length)) + 'd'
    # (action = (text.split('.')[1])) == "destroy" ? action<<"ed" : action<<"d"
    (action = (text.slice((text.index('.')+1)..(text.length)))) == "destroy" ? action<<'ed' : action<<'d'
  	activity = action + " a " + thing + " at "
    return activity
  end

end
