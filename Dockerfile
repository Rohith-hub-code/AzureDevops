FROM ubuntu:26.04
MAINTAINER Rohith 
RUN apt-get update 
RUN mkdir testData 
RUN cd testData 

WORKDIR testData/ 

RUN touch t1 t2 t3 
COPY config.txt .
EXPOSE 8080 



