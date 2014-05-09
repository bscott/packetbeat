FROM ubuntu
MAINTAINER Brian L. Scott "Brainscott@gmail.com"
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:letmein' |chpasswd
RUN sudo apt-get install curl -y
RUN sudo apt-get install default-jre -y
RUN curl -L -O https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.0.deb
RUN sudo dpkg -i elasticsearch-1.1.0.deb
RUN echo "Installing Kibana..."
RUN curl -L -O https://github.com/packetbeat/kibana/releases/download/v3.0.0-pb/kibana-3.0-packetbeat.tar.gz
RUN tar -xzvf kibana-3.0-packetbeat.tar.gz
RUN cd kibana-3.0-packetbeat

CWD ["kibana-3.0-packetbeat"]

EXPOSE 8000
EXPOSE 9200
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
CMD ["sudo","/etc/init.d/elasticsearch", "start"]
CMD ["python", "-m", "SimpleHTTPServer"]
