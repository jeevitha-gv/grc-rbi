class ActivitiesController < ApplicationController

  helper_method :parse_and_convert
 
  def index
   @activities = PublicActivity::Activity.all
  end

  def parse_and_convert(text)
  	thing = text.slice(0..(text.index('.')-1))
  	action = text.slice((text.index('.')+1)..(text.length)) + 'd'
  	activity = action + " a " + thing + " at "
    return activity
  end

end
