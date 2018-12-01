name             'artifactory'
maintainer       'Agile Orbit'
maintainer_email 'info@agileorbit.com'
license          'Apache-2.0'
description      'Installs/Configures artifactory'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.3'

depends          'java'
depends          'runit'
depends          'ark'
depends          'apache2'

supports 'ubuntu'
supports 'debian'
supports 'redhat'

source_url 'https://github.com/agileorbit-cookbooks/artifactory' if defined?(:source_url)
issues_url 'https://github.com/agileorbit-cookbooks/artifactory/issues' if defined?(:issues_url)

chef_version '>= 12.17' if respond_to?(:chef_version)
