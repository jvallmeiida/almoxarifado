class MaterialLogsController < ApplicationController
  def index
    @logs = MaterialLog.all
  end

  def show
    @logs = Material.find(params[:material_id]).material_logs
  end
end