class HomeController < ApplicationController
  def index
    @materials = Material.all
    @users = User.all
    @logs = MaterialLog.all
  end
end