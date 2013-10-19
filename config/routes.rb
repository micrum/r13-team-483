RubyBench::Application.routes.draw do

  resources :samples

  resources :sample_groups

  if Rails.env.production?
    root :to => 'home#stub'
  else
    root :to => 'home#index'
  end

end
