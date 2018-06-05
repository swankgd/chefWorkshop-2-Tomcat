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

directory '/opt/tomcat' do
	group 'tomcat'
	recursive true
end

directory 'opt/tomcat/webapps' do
	owner 'tomcat'
	recursive true
end

directory 'opt/tomcat/work' do
	owner 'tomcat'
	recursive true
end

directory 'opt/tomcat/temp' do
	owner 'tomcat'
	recursive true
end

directory 'opt/tomcat/logs' do
	owner 'tomcat'
	recursive true
end

execute 'add_group_read_conf' do
	command 'chmod -R g+r conf'
end

execute 'add_group_execute_conf' do
	command 'chmod g+x conf'
end