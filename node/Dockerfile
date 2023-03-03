#hangi base imajı kullanacaksak ponu belirtiyoruz.
FROM node

RUN apt update && apt install vim -y

#hangi klasör altına uygulamamızı kopyalayacaksak onu belirtiyoruz.
WORKDIR /app

LABEL pr="prod"

#uygulamamızın dosyalarını kopyalıyoruz.
COPY app.js .


#hangi porttak yayın yapacaksak onu belirtiyoruz.
EXPOSE 8888

#en son olarakta hangi process ve uygulamayı çalıştıracaksak onu belirtiyoruz.
CMD ["node","app.js"]
