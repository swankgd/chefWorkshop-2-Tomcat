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