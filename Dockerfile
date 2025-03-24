FROM python:3.7-buster

RUN pip install pipenv && \
    pipenv install && \

COPY . .

CMD ["pipenv", "run", "python3", "server.py"]