#
# Cookbook Name:: artifactory
# Recipe:: default
#
# Copyright (C) 2013 Fewbytes
#
# Apache V2
#
# TODO: move zip install to its own Recipe

if node['artifactory']['install_java']
  node.normal['java']['jdk_version'] = node['artifactory']['java']['jdk_version']
  include_recipe 'java'
end

case node['platform_family']
when 'rhel'
  include_recipe '::_rpm_install'
when 'debian'
  include_recipe '::_apt_install'
else
  include_recipe '::_zip_install'
end
