ActionController::Routing::Routes.draw do |map|
  map.connect '/ops/version', :controller => 'ops', :action => 'version'
  map.connect '/ops/heartbeat', :controller => 'ops', :action => 'heartbeat'
  map.connect '/ops/heartbeat/:name', :controller => 'ops', :action => 'heartbeat'
end
