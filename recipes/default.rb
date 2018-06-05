#
# Cookbook:: install_tomcat
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package 'java-1.7.0-openjdk-devel'

group 'tomcat'
	
user 'tomcat' do
	shell '/sbin/nologin'
	manage_home false
	gid 'tomcat'
	home '/opt/tompcat'
end

remote_file '/tmp/apache-tomcat-8.5.31.tar.gz' do
	source 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.31/bin/apache-tomcat-8.5.31.tar.gz'
end

directory '/opt/tomcat'

execute 'untar_tomcat_bin' do
	command 'tar xvf /tmp/apache-tomcat-8.5.31.tar.gz -C /opt/tomcat --strip-components=1'
	not_if { File.exists?("/opt/tomcat/Running.txt") }
end


execute 'chgrp_recusrive_tomcat' do
	command 'chgrp -R tomcat /opt/tompcat'
end

directory '/opt/tomcat/bin' do
	group 'tomcat'
	recursive true

directory '/opt/tomcat/webapps' do
	owner 'tomcat'
	recursive true
end

directory '/opt/tomcat/work' do
	owner 'tomcat'
	recursive true
end

directory '/opt/tomcat/temp' do
	owner 'tomcat'
	recursive true
end

directory '/opt/tomcat/logs' do
	owner 'tomcat'
	recursive true
end

execute 'add_group_read_conf' do
	command 'chmod -R g+r /opt/tomcat/conf'
end

execute 'add_group_execute_conf' do
	command 'chmod g+x /opt/tomcat/conf'
end

file '/etc/systemd/system/tomcat.service' do
	content "# Systemd unit file for tomcat
[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/bin/kill -15 $MAINPID

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target"
end

execute 'systemd_reload' do
	command 'systemctl daemon-reload'
end

service 'tomcat' do
	action [:enable, :start]
end