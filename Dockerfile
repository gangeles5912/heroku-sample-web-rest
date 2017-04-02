# Downloaded from https://gist.github.com/diegopacheco/00113bbf900013214504
FROM java:8
MAINTAINER Diego Pacheco - diego.pacheco.it@gmail.com

RUN apt-get update && \ 
    apt-get install -y \
	git \ 
	wget

WORKDIR /usr/local/

RUN rm -rf jetty*

RUN wget --no-check-certificate -O jetty.tar.gz http://eclipse.org/downloads/download.php?file=/jetty/9.3.3.v20150827/dist/jetty-distribution-9.3.3.v20150827.tar.gz > /dev/null 2>&1

RUN tar -xzvf jetty.tar.gz
RUN rm -rf jetty.tar.gz
RUN mv jetty-distribution-9.3.3.v20150827/ jetty9
ADD target/heroku.war /usr/local/jetty9/webapps/
EXPOSE 8080
WORKDIR /usr/local/jetty9

CMD ["java", "-jar", "/usr/local/jetty9/start.jar"]

#
# to Build: $ docker docker build -t diegopacheco/jetty . 
# to Run  : $ docker run -P -d diegopacheco/jetty
# to Enter: $ docker exec -it CONTAINER_ID bash
# 
