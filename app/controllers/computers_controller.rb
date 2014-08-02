class ComputersController < ApplicationController
  def index
  	@computers = current_company.computers
  end
end
