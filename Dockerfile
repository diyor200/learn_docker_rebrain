# Используем Python 3.7
FROM python:3.7-buster

# Устанавливаем pipenv и обновляем pip
RUN pip install --upgrade pip && pip install setuptools==57.5.0 pipenv

# Создаём рабочую директорию
WORKDIR /app

# Копируем файлы проекта
COPY Pipfile Pipfile.lock ./

# Устанавливаем зависимости (без `--deploy`, если лок нужен)
RUN pipenv install --skip-lock

# Копируем остальные файлы проекта
COPY . .

# Указываем команду запуска
CMD ["pipenv", "run", "python", "server.py"]
