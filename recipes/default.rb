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

