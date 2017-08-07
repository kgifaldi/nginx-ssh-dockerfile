FROM nginx
USER root
RUN apt-get update; apt-get install -y openssh-server openssh-client; 
CMD echo "root:jenkins" | chpasswd 
CMD echo 'server { listen       80; location / { root   /home/jenkins/public; index  index.html index.htm; autoindex on; } error_page   500 502 503 504  /50x.html; location = /50x.html { root   /usr/share/nginx/html; } }' > /etc/nginx/conf.d/default.conf
CMD echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
CMD mkdir /home/jenkins/
CMD mkdir /home/jenkins/public/
CMD mkdir /home/jenkins/public/toolbelt/
CMD echo '<!DOCTYPE html>\n\
<html>\n\
\n\
<xmp theme="united" style="display:none;">\n\
\n\
# AU2-Toolbelt Artifacts\n\
\n\
This directory hosts recent versions of the AU2-Toolbelt. Everytime the toolbelt code is updated, it\'s automatically compiled into three different "artifacts", or executables for different operating systems (Windows, MacOS, and linux). These are then stored in a new folder at artifacts.aunalytics.com/toolbelt. If you want to download the newest version of the toolbelt, just go to the address above, click on the highest numbered folder, then click on the link that corresponds with your operating system: \n\
* aunsight-toolbelt2-linux (**Linux**)\n\
* aunsight-toolbelt2-macos (**MacOS**)\n\
* aunsight-toolbelt2-win.exe (**Windows**)\n\
\n\
Then, you should navigate to the folder where the file downloaded, add executable permissions to it (`chmod +x ./aunsight-toolbelt2-*`), and then you should be able to use the toolbelt normally:\n\
```\n\
$ ./aunsight-toolbelt2-macos --help\n\
\n\
aunsight-toolbelt2-macos /snapshot/aunsight-toolbelt/index.js <command>\n\
\n\
Commands:\n\
  admin         Administrative commands\n\
  context       View user & organization contexts\n\
  data          CRUD datasets\n\
  dataflow      CRUD dataflows\n\
...\n\
...\n\
...\n\
```\n\
\n\
### Aliasing to "au2" \n\
\n\
If you want to use the toolbelt executable from any folder, you will need to add an alias to your ~/.bashrc file. You can do this by navigating to the where the toolbelt executable exists (probably in your downloads folder), then entering these two commands (**after changing the \<OS\> to macos/linux/win.exe**) into the terminal: \n\
\n\
```\n\
$ echo "alias au2=\"$(pwd)/aunsight-toolbelt2-<OS>\"" >> ~/.bashrc\n\
$ source ~/.bashrc\n\
```\n\
Then you should be able to use the toolbelt from any directory:\n\
\n\
```\n\
$ au2 --help\n\
\n\
aunsight-toolbelt2-macos /snapshot/aunsight-toolbelt/index.js <command>\n\
\n\
Commands:\n\
  admin         Administrative commands\n\
  context       View user & organization contexts\n\
...\n\
...\n\
...\n\
```\n\
\n\
Here is a link to view the latest versions: <a href="./">artifacts.aunalytics.com/toolbelt</a>\n\
\n\
</xmp>\n\
\n\
\n\
<script src="http://strapdownjs.com/v/0.2/strapdown.js"></script>\n\
</html>' > /home/jenkins/public/toolbelt/README.html
CMD /etc/init.d/ssh stop
CMD /etc/init.d/ssh start
