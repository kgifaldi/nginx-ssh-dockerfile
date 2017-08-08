FROM nginx
USER root
RUN apt-get update; apt-get install -y openssh-server; apt-get install -y openssh-client; apt-get install -y curl; 
RUN echo "root:jenkins" | chpasswd 
RUN echo 'server { listen       80; location / { root   /home/jenkins/public; index  index.html index.htm; autoindex on; } error_page   500 502 503 504  /50x.html; location = /50x.html { root   /usr/share/nginx/html; } }' > /etc/nginx/conf.d/default.conf
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN mkdir /home/jenkins/
RUN mkdir /home/jenkins/public/
RUN mkdir /home/jenkins/public/toolbelt/
RUN curl https://bitbucket.org/kgifaldi/nginx-readme/raw/0d843e02521d592626c654de2321c4877c83cd91/README.html > /home/jenkins/public/README.html
RUN /etc/init.d/ssh stop
RUN /etc/init.d/ssh start
