RubyBench::Application.routes.draw do

  resources :samples

  resources :sample_groups, path: 'benchmark' do
    get 'results', :to => 'sample_groups#results'
  end

  if Rails.env.production?
    root :to => 'home#stub'
  else
    root :to => 'sample_groups#index'
  end

end

