class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
  end

  def version_number
    @version_number = 0.1
  end
end
