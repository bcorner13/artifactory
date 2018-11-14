# Attributes
# source code URL http://dl.bintray.com/content/jfrog/artifactory/

module Artifactory
  comment 'This defines the version of artifactory to install'
  class << self
    attr_accessor :version
  end
end

Artifactory.version = '5.5.1'
default['artifactory']['artifactory_version '] = Artifactory.version
default['artifactory']['install_type'] = 'rpm'
default['artifactory']['zip_url'] = "http://dl.bintray.com/content/jfrog/artifactory/jfrog-artifactory-oss-#{Artifactory.version}.zip"
default['artifactory']['zip_checksum'] = '993d9abd188a6b1eaf4c762f201f0ba70f545ca68ad099f9a9a48bec3470d68d'
default['artifactory']['home'] = '/var/lib/artifactory'
default['artifactory']['log_dir'] = '/var/log/artifactory'
default['artifactory']['catalina_base'] = ::File.join(node['artifactory']['home'], 'tomcat')
default['artifactory']['java']['xmx'] = '1g'
default['artifactory']['java']['xms'] = '512m'
default['artifactory']['java']['extra_opts'] = '-XX:+UseG1GC'
default['artifactory']['java']['jdk_version'] = 8

default['artifactory']['user'] = 'artifactory'
default['artifactory']['group'] = 'artifactory'
default['artifactory']['port'] = 8081
default['artifactory']['shutdown_port'] = 8015
default['artifactory']['install_java'] = true

default['artifactory']['use_ajp'] = false
default['artifactory']['ajp']['port'] = 8019
default['artifactory']['ajp']['maxThreads'] = 500
default['artifactory']['ajp']['minSpareThreads'] = 20
default['artifactory']['ajp']['enableLookups'] = false
default['artifactory']['ajp']['backlog'] = 100

# RPM based installations
default['artifactory']['repo_url'] = nil
default['artifactory']['version '] = '5.5.1'
