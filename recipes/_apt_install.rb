#
# Cookbook Name:: artifactory
# Recipe:: default
#
# Copyright (C) 2013 Fewbytes
#
# Apache V2
#
# TODO: Test the apt install on debian-8

if node['artifactory']['install_java']
  node.normal['java']['jdk_version'] = node['artifactory']['java']['jdk_version']
  include_recipe 'java'
end
package 'apt-transport-https'
apt_repository 'artifactory' do
  uri node['artifactory']['apt'][node['artifactory']['artifactory_type']]['url']
  components ['main']
  key 'https://bintray.com/user/downloadSubjectPublicKey?username=jfrog'
  action :add
end
package node['artifactory']['apt'][node['artifactory']['artifactory_type']]['install_name'] do
  version node['artifactory']['artifactory_version']
  action :install
end

service 'artifactory' do
  supports status: true
  action [:enable, :start]
end
# TODO: copy/import configuration and licenses
# template '/usr/local/artifactory/tomcat/conf/server.xml' do
#   mode 0o0644
#   notifies :restart, 'service[artifactory]'
# end
# TODO: Talk with Raj to find out what else needs to be done to fully automate spin up.
