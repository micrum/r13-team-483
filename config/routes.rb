RubyBench::Application.routes.draw do

  resources :samples


  # Small hack for creating benchmark by some template
  post 'benchmark/new' => 'sample_groups#new'

  resources :sample_groups, path: 'benchmark' do
    get 'results', :to => 'sample_groups#results'

    if Rails.env.development?
      member do
        get 'run' => 'sample_groups#run'
      end
    end
  end

  root :to => 'home#index'
  #root :to => 'sample_groups#index'

end

