Rails.application.routes.draw do
  root :to => "properties#index", :defaults => { :format => 'json' }
end
