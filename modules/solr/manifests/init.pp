# == Class: solr
#
# This module helps you create a multi-core solrcloud
#
# IMPORTANT: Works only with Ubuntu as of now.
#
# === Parameters
#
# [*cores*]
#   "Specify the solr cores you want to create (optional)"
#
# === Examples
#
# Default case, which creates a single core called 'default'
#
#  include solr
#
# If you want multiple cores, you can supply them like so:
#
#  class { 'solr':
#    cores => [ 'development', 'staging', 'production' ]
#  }
#
# === Authors
#
# Vamsee Kanakala <vamsee AT riseup D0T net>
# Fabrizio Sabatini <fabrizio.sabatini AT dice D0T com>
#

class solr (
  $cores      = 'UNSET',
  $version    = 'UNSET',
  $mirror     = 'UNSET',
) {

  include solr::params

  $my_cores = $cores ? {
    'UNSET'   => $::solr::params::cores,
    default   => $cores,
  }

  $my_version = $version ? {
    'UNSET'   => $::solr::params::solr_version,
    default   => $version,
  }

  $my_mirror = $version ? {
    'UNSET'   => $::solr::params::mirror_site,
    default   => $mirror,
  }

  class {'solr::install': } ->
  class {'solr::config':
    cores   => $my_cores,
    version => $my_version,
    mirror  => $my_mirror,
  } ~>
  class {'solr::service': } ->
  Class['solr']

}
