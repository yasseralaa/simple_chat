class HomeController < ApplicationController

  def index
    @allusers = User.all
  end
end
