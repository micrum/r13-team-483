RubyBench::Application.routes.draw do

  resources :samples

  resources :sample_groups

  root :to => 'home#index'
end
