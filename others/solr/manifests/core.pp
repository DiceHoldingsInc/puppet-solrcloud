# == Definition: solr::core
# This definition sets up solr config and data directories for each core
#
# === Parameters
# - The $core to create
#
# === Actions
# - Creates the solr web app directory for the core
# - Copies over the config directory for the file
# - Creates the data directory for the core
#
define solr::core(
  $core_name = $title,
) {
  include solr::params

  $solr_home  = $solr::params::solr_home

  #Finally, create the data directory where solr stores
  #its indexes with proper directory ownership/permissions.
  file { "${solr_home}/${core_name}":
    ensure => directory,
    owner  => 'jetty',
    group  => 'jetty'
  }

  file { "${solr_home}/${core_name}/data":
    ensure => directory,
    owner  => 'jetty',
    group  => 'jetty'
  }

  file { "${solr_home}/${core_name}/core.properties":
    ensure  => present,
    owner   => 'jetty',
    group   => 'jetty',
    content => "name=${core_name}"
  }

}
