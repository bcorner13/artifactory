#
# Cookbook Name:: artifactory
# Recipe:: default
#
# Copyright (C) 2013 Fewbytes
#
# Apache V2
#

if node['artifactory']['install_java']
  node.normal['java']['jdk_version'] = node['artifactory']['java']['jdk_version']
  include_recipe 'java'
end

case node['platform_family']
when 'rhel'
  include_recipe '::_rpm_install'
when 'debian'
  include_recipe '::_apt_install'
when 'zip'
  include_recipe '::_zip_install'
end
