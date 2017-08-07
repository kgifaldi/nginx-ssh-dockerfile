FROM nginx
USER root
RUN apt-get update; apt-get install -y openssh-server openssh-client; 
CMD echo "root:jenkins" | chpasswd 
CMD echo 'server { listen       80; location / { root   /home/jenkins/public; index  index.html index.htm; autoindex on; } error_page   500 502 503 504  /50x.html; location = /50x.html { root   /usr/share/nginx/html; } }' > /etc/nginx/conf.d/default.conf
CMD echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
CMD mkdir /home/jenkins/
CMD mkdir /home/jenkins/public/
CMD mkdir /home/jenkins/public/toolbelt/
CMD /etc/init.d/ssh start
