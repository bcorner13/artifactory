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

include_recipe 'runit'
package 'unzip'
# ark requires rsync package
package 'rsync'

user node['artifactory']['user'] do
  home node['artifactory']['home']
end

group node['artifactory']['group'] do
  members [node['artifactory']['user']]
end

directory node['artifactory']['home'] do
  owner node['artifactory']['user']
  group node['artifactory']['group']
  mode 0o0755
  recursive true
end

directory node['artifactory']['catalina_base'] do
  owner node['artifactory']['user']
  group node['artifactory']['group']
  mode 0o0755
  recursive true
end

%w(work temp).each do |tomcat_dir|
  directory ::File.join(node['artifactory']['catalina_base'], tomcat_dir) do
    owner node['artifactory']['user']
    group node['artifactory']['group']
    mode 0o0755
  end
end

directory node['artifactory']['log_dir'] do
  owner node['artifactory']['user']
  group node['artifactory']['group']
  mode 0o0755
end
ark 'artifactory' do
  url node['artifactory']['zip_url']
  checksum node['artifactory']['zip_checksum']
  owner node['artifactory']['user']
  group node['artifactory']['group']
  action :install
end

link ::File.join(node['artifactory']['home'], 'webapps') do
  to '/usr/local/artifactory/webapps'
end

link ::File.join(node['artifactory']['catalina_base'], 'logs') do
  to node['artifactory']['log_dir']
end

link ::File.join(node['artifactory']['catalina_base'], 'conf') do
  to '/usr/local/artifactory/tomcat/conf'
end

template '/usr/local/artifactory/tomcat/conf/server.xml' do
  mode 0o0644
  notifies :restart, 'runit_service[artifactory]'
end


runit_service 'artifactory'
