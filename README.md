# install_tomcat

DESCRIPTION
This cookbook installs JDK and Tomcat v8.5.31 on an x64 RHEL-based system

REQUIREMENTS
x64 RHEL based node with internet access (tested with chef-client v.13.8.5)

Error-free cookbook versions
Version 0.1.0
Installs JDK v 1.7.0
validation: rpm -qa | grep jdk

Version 0.2.1
creates user tomcat
validation: cat /etc/passwd | grep tomcat

Version 0.3.0
downloads Tomcat 8.5.31 
validation: ls /tmp | grep tomcat

Version 0.4.1
Untars tomcat binaries
validation: ls /opt/tomcat

Version 0.5.1
sets ownership and permissions for binary installation directories/files
NOTE: Recursive group ownership setting will not work properly, fixed in 0.7.x
validation: ll /opt/tomcat

Versoin 0.6.0
Creates /etc/systemd/system/tomcat.service
NOTE: syntax error using incorrect quotes. This version will not create the file, fixed in 0.7.x 
validation: cat /etc/systemd/system/tomcat.service

Version 0.7.6
Fixes issue with recursive directory group assignment
Fixes issue with tomcat.service file creation
Restarts serviced and starts tomcat service
validation: curl localhost

TODO
Reduce dependency on "execute" resources in recipe
Paramaterize JDK and Tomcat versions
Templatize tomcat.service file

