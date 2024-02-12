Rails.application.routes.draw do
 resources :users 
 resources :tasks do
  post :mark_as_complete, on: :collection
 end
   resources :sub_tasks do
    post :mark_as_complete, on: :collection
  end


end
