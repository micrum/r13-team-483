RubyBench::Application.routes.draw do

  resources :samples

  resources :sample_groups, path: 'benchmark'

  if Rails.env.production?
    root :to => 'home#stub'
  else
    root :to => 'sample_groups#index'
  end

end

