class UrlsController < ApplicationController
  def index
    @urls = Url.new # инстанцируем новую запись
  end

  def show
    key = params[:id].to_s   # Присваиваем ключ, по которому перешел пользователь
    if (Url.find_by key: key).blank? # Проверяем наличие ключа в бд
      redirect_to '/urls' # Если ключа нет, то отправляем
    else                                           # На начальную страничку
      @urls = (Url.find_by key: key)    # Если ключ нашелся, то
      redirect_to @urls.url # перенаправляем по полному url
      @urls.counter +=1                 # и увеличиваем счетчик на 1
      @urls.save                        # Сохраняем изменения
    end
  end

  def create
    if params[:url].nil?  # Проверяем, не была ли отправлена пустая форма
      redirect_to '/urls' # В этом случае отправляем ее корректно заполнить
    else
      url = params[:url].to_s  # присваиваем полное url и преобразовываем в строку
      url = url[9..(url.length - 3)] # Отбрасываем лишнее
      key = longURLToShortURL(url) # Получаем наш ключ
      @urls = Url.create(url: url, key: key, counter: 0) # Создаем запись
      @urls.save  # Добавляем запись. Полученная короткая ссылка выведется через
    end           # create.html.erb
  end

  private

  def longURLToShortURL(url)   # Функция для генерирования ключей
    chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    short_url = ""
    rnd = Random.new
    id = url.to_s.length + rnd.rand(10000..100000)
    while (id > 0) do
      short_url += chars[id % 62]
      id /= 62
    end
    short_url
  end

end
