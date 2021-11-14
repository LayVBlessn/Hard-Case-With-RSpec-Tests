class StatsController < ApplicationController
  def index
    key = request.original_fullpath.to_s # Присваиваем url
    key = key[6..key.length - 7] # Забираем срезом из него ключ
    if Url.find_by_key(key).blank? # Проверяем, существует ли запись в бд по данному ключу
      redirect_to '/urls', status: '404 Not Found'
    else                            # Если не существует, перенаправляем на /urls
      @stats = Url.find_by_key(key) # и выдаем ошибку
                                    # Если существует, то
    end                             # Присваем @urls значение из поля counter
  end                               # И выводим через index.html.erb
end
