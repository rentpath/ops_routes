if Rails::VERSION::MAJOR == 3
  Rails.application.routes.draw do |map|
    match '/ops/version', :to => 'ops#version'
    match '/ops/heartbeat(/:name)', :to => 'ops#heartbeat'
    match '/ops/configuration', :to => 'ops#configuration'
  end
else  
  ActionController::Routing::Routes.draw do |map|
    map.connect '/ops/version', :controller => 'ops', :action => 'version'
    map.connect '/ops/heartbeat', :controller => 'ops', :action => 'heartbeat'
    map.connect '/ops/heartbeat/:name', :controller => 'ops', :action => 'heartbeat'
    map.connect '/ops/configuration', :controller => 'ops', :action => 'configuration'
  end
end
