RubyNumerals::Application.routes.draw do

  root to: 'converter#index'

  match '/phrase', to: 'converter#phrase', as: :phrase, via: :post

end
