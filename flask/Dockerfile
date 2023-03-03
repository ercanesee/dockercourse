FROM python

RUN apt update && apt install vim -y

RUN  pip install flask

WORKDIR /app

ENV NAME=ercan
LABEL ppy = "prod"

COPY . .

EXPOSE 80

CMD ["flask","run","--host=0.0.0.0","--port=80"]