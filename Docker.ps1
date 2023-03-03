#Docker versiyonu öğrenme.
docker version

#Bir container ayağa kaldırabilmek için bir imaja ihtiyaç var.
#Container Registry Container Private Repository
#Üzerinde çalışan process ayakta kalana kadar container kapanmaz.
#Default olarak imajlar hub.docker.com üzerinden indirilmeye çalışılır.
#imajların nereden indireceğinizi belirttiğiniz kısım aşağıdaki şekildedir.
docker pull <imagerepo>/imagename:tag
#bir imaj indirmek için
docker pull node:v1
#imajları görüntülemek için.
docker images
#İmajları tage göre indirmek istersek.
docker pull node:19-alpine 

#Örnekler
#nginx imajını indirin ve indirdiğinizi görüntüleyin.
docker pull nginx
#redis versiyon 6.0.18 alpine imajını indirin.
docker pull redis:6.0.18-alpine 
#repo.ercanese.com reposundan node 1.7.3 imajını indiren kodu yazın.
docker login <privaterepo>
docker pull repo.ercanese.com/node:1.7.3
#dotnet runtime 7.0 docker imajını indirin.
docker pull mcr.microsoft.com/dotnet/runtime:7.0
#haproxy 2.8 dev versiyonunu indirelim.
docker pull haproxy:2.8-dev

#Image üzerinden bir container türetmek için.

docker run busybox <command>

#alpine imajını calıstırarak ekrana hello world yazın
docker run alpine echo hello world
#busybox imajını çalıştırarak ekrana bügünün tarihini yazın.
docker run busybox date

#bir container shelline girebilmek için
docker run -it alpine /bin/sh

#alpine container içerisine girerek bir adet txt dosyası olsuturun.
docker run -it alpine /bin/sh
docker run alpine sh -c 'mkdir demo'
docker run ubuntu /bin/bash -c "apt update && apt install iputils-ping -y && ping 8.8.8.8"


#ubuntu container içerisine girerek ekranda bugünün tarihini görelim.
docker run -it ubuntu /bin/bash
date
#ubuntu container içerisinde bir while loop sh scripti olustuurup bunu calsıtıralım.
docker run -it ubuntu /bin/bash
apt update
apt install vim
vi demo.sh
while true; do echo 'naber'; sleep 1; done 
chmod +x demo.sh
./demo.sh

#bir adet ubuntu container ayaga kaldıralım ve içerisine figlet paketini yükleyerek figlet ile isminizi şekilli yazın.
docker run -it ubuntu /bin/bash
apt update && apt install figlet
figlet demo

#container arka planda çalıştırmak için çalışan bir  processe ihtiyacı vardır

docker run -d jpetazzo/clock
docker run -d ubuntu /bin/bash -c "while"

#çalışan veya çalışmayan tüm containerlar listelenir.
docker ps -a

#çalışan veya calısmayan tüm contaienrların sadece idsini listeler.
docker ps -qa

#containerlarımı silmek için kullandığımız komut
docker rm <containerid>
docker rm $(docker ps -qa)  #tüm containerları silmeye calısır calıslanarı silmez.
docker rm $(docker ps -qa) -f #tüm containerları siler.

docker stop <containerid>
docker start <containerid>
docker rm <containerid>    

#çalışan bir container force etmek için.
docker rm 034 -f 

docker run -d ubuntu /bin/bash -c 'while true; do date; sleep 1; done'

docker run -d jpetazzo/clock

docker run -d --name balog-redis ubuntu /bin/bash -c 'while true; do date; sleep 1; done'

#yukaradaki containerdan 4 adet üretelim ve isimleri hcm-portal hcm-redis  hcm-sql hcm-mongo olsun
docker run -d --name hcm-portal ubuntu /bin/bash -c 'while true; do date; sleep 1; done'
#bunları stop kill kullanarak kapatalım.
docker stop <containername or containerid>
docker kill <containerid or containername>
docker rm <containername or containerid>

#sonrada rm ile silelim.


#calısan veya calısmayan bir container içerisindeki logları ekranda göstermek için.
docker logs <containerid>
docker logs --tail 3 # en son 3 log
docker logs --follow # logları takip etmek.

#while ile başlayan containeri arka planda calıstırın ve loglarını follow yöntemi ile kontrol edin.
docker run -d --name hcm-portal ubuntu /bin/bash -c 'while true; do date; sleep 1; done'
docker logs <containerid> --follow
#ekrana date yazan bir container ortaya cıkarın ama detach modda arka planda calıssın. sonra bu container loglarını kontrol edin.
docker run -d ubuntu /bin/bash -c date
docker logs <containerid>


docker logs <container> --since 5m # 5 dakika içerisindeki logları ekranda göstermeye yarar.

#container dışarı açmak için host ile arasında bağlantı sağlamak gerekir.
docker run -d --name nginx01 -p 8091:80 nginx
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Deneme123456!" -p 9094:1433 -d mcr.microsoft.com/mssql/server:2022-latest #dışarıdan env değeri vermek istersek
#e parametresiyle beraber vereceğimiz değeri belirlememiz gerekiyor.


#çalışan bir container içerisine shell ekranına girmek için.
docker exec -it <containerid or containername> /bin/bash or /bin/sh

#nginx imajından bir container üretelim ve bu ürettiğimiz container içerisinde index.html aşağıdaki şekilde güncelleyelim.

"<!DOCTYPE html>
<html>
<body>

<h1>My First Heading</h1>
<p>My first paragraph.</p>

</body>
</html>"
usr/share/nginx/html


#oluşturdugumuz containerları direk olarak imaj haline getirmek için.
docker commit <containerid> <containername:tag>

#ubuntu imajına figlet kurarak sonrasında bunu bir imaj haline getirin.
docker run -it ubuntu /bin/bash
apt update
apt install figlet
exit
docker commit <containerid> <targetcontainernam:tag>

docker run <targercontainername> figlet demo
#ubuntu imajına bir sh dosyası koyarak ekrana devamlı isminizi basacak scripti imaj halinde calıstırın.

docker run -it ubuntu /bin/bash
apt update
apt install vi

script.sh
chmod +x script.sh
docker commit <containerid> <targetcontainernam:tag>



docker run -it node /bin/bash #node imajına giriş yapmak için kullanıyoruz.

apt update
apt install vim -y
mdkir app
cd app

vi app.js
"
var http = require('http')

http.createServer(onRequest).listen(8888);
console.log('Server has started');

function onRequest(request, response){
  response.writeHead(200);
  response.write('Hello Noders');
  response.end();
}
"
node app.js

exit

docker commit <containerid> <newimagename> #containerdan imaj almak için kullanıyoruz.

docker run -d -p 9999:8888 --name node01 <newimagename> node /app/app.js #imajını aldığımız node uygulamasının çalıştırılmasını sağlıyoruz.

docker commit --change='CMD ["node","/app/app.js"]' <containerid> <newimagename> #commit alırken CMD komutunu değiştirerek direk imajı çalıştırarak uygulamamızı çalıştırıyoruz.



#imajları silmek için 

docker rmi <imageid>



docker cp app.js f6dd089cafdc:/app/app.js
docker commit --change='CMD ["node","/app/app.js"]' f6dd089cafdc demonode


docker pull python

docker run -d --name pyt01 python /bin/bash -c "pip install flask && mkdir app"

vi app.py

from flask import Flask

app = Flask(__name__) # app değişkenizimizin Flask olduğunu belirttik.

@app.route("/") # Endpoint imizi tanımladık.
def hello(): # Bir fonksiyon oluşturduk.
    return "Hello World" # Sitemizde görmek istediğimiz şeyi return ettik.


docker cp app.py <containerid>:/app 
docker commit --change='WORKDIR /app' --change='CMD ["flask","run","--host=0.0.0.0","--port=80"]' 194 flaskdemo