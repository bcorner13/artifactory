#
# Cookbook Name:: artifactory
# Recipe:: default
#
# Copyright (C) 2013 Fewbytes
#
# Apache V2
#
# TODO: Test installation on centos-6 and centos-7

if node['artifactory']['install_java']
  node.normal['java']['jdk_version'] = node['artifactory']['java']['jdk_version']
  include_recipe 'java'
end
# default['artifactory'] = {
#   'pro' => { 'rpm_url': 'https://bintray.com/jfrog/artifactory-pro-rpms/rpm ',
#              'install_name': 'jfrog-artifactory-pro' },
#   'ce' => { 'rpm_url': 'https://bintray.com/jfrog/artifactory-rpms/rpm',
#             'install_name': 'jfrog-artifactory-cpp-ce' },
#   'oss' => { 'rpm_url': 'https://bintray.com/jfrog/artifactory-rpms/rpm',
#              'install_name': 'jfrog-artifactory-oss' },
# }

yum_repository 'artifactory' do
  description 'Jfrog Artifactory Stable repo'
  baseurl node['artifactory']['rpm'][node['artifactory']['artifactory_type']]['url']
  gpgcheck false
  repo_gpgcheck false
  action :create
end
package node['artifactory']['rpm'][node['artifactory']['artifactory_type']]['install_name'] do
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
