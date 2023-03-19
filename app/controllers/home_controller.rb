class HomeController < ApplicationController
  def index
    if current_user
      redirect_to categories_path
    end
  end
end

# @Todo: Add drawer menu with logout option
# @Todo: Implement navigation