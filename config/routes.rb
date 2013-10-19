RubyBench::Application.routes.draw do

  resources :sample_groups

  root :to => 'home#index'
end
