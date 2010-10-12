if Rails::VERSION::MAJOR == 3
  Rails.application.routes.draw do |map|
    map '/ops/version', :to => 'ops#version'
    map '/ops/heartbeat(/:name)', :to => 'ops#heartbeat'
    map '/ops/configuration', :to => 'ops#configuration'
  end
else  
  ActionController::Routing::Routes.draw do |map|
    map.connect '/ops/version', :controller => 'ops', :action => 'version'
    map.connect '/ops/heartbeat', :controller => 'ops', :action => 'heartbeat'
    map.connect '/ops/heartbeat/:name', :controller => 'ops', :action => 'heartbeat'
    map.connect '/ops/configuration', :controller => 'ops', :action => 'configuration'
  end
end
