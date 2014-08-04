class ComputersController < ApplicationController

  def index
  	@computers = current_company.computers
  end

  def new
    @computer = Computer.new
  end
  
end
