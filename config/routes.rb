Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  resources :courses
  resources :students do
    # Poderia ter feito um novo resource para a classroom, mas preferi deixar
    # tudo no mesmo controller.
    get 'new_enrollment' => 'students#new_enrollment'
    post 'create_enrollment' => 'students#create_enrollment'
    delete 'destroy_enrollment' => "students#destroy_enrollment"
  end

end
