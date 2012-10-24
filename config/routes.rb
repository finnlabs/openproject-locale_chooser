ActionController::Routing::Routes.draw do |map|
  map.my_locale 'my/locale', :controller => 'locales',
                             :action => 'update',
                             :conditions => { :method => :put }
end
