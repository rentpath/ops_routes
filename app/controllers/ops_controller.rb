class OpsController < ApplicationController
  
  def version
    render :text => OpsRoutes.check_version(request.headers)
  end
  
  def heartbeat
    response.content_type = "text/plain"
    render OpsRoutes.check_heartbeat(params[:name])
  end

end
