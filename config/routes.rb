RubyBench::Application.routes.draw do

  resources :samples

  resources :sample_groups, path: 'benchmark' do
    if Rails.env.development?
      member do
        get 'run' => 'sample_groups#run'
      end
    end
  end




  if Rails.env.production?
    root :to => 'home#stub'
  else
    root :to => 'sample_groups#index'
  end

end

