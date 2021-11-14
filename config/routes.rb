Rails.application.routes.draw do  # Наши маршруты
  resources :urls, only: %i[index new create show] do # Создаем для маршруты для urls
    resources :stats, only: [:index]
  end

end
