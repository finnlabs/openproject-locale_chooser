OpenProject::Application.routes.draw do
  put 'my/locale', :to => 'locales#update'
end
