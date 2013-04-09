ThirtyThirty::Application.routes.draw do
  post '' => 'home#solve'
  root to: 'home#index'
end
