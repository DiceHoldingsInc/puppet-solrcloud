Solrcloud Module
=================

*THIS MODULE IS IN TESTING*

After I moved things around to make it work, this is no more a puppet module,
but a vagrant wrapper.

## Description

This is a puppet module for setting up a multi-core solr cluster able to connect
to Zookeeper. This module is a fork of

    https://github.com/vamsee/puppet-solr

Zookeeper is not installed and configured by this module (IT IS NOT CONSIDERED A
PUPPET REQUIREMENT) but it still sort of believe you installed it there. Do not
disappoint it.

Also the configuration for Solr should be in ZK otherwise you will receive the
following error from Solr UI:

    SolrCore Initialization Failures
    xxx: org.apache.solr.common.cloud.ZooKeeperException:org.apache.solr.common.cloud.ZooKeeperException: Could not find configName for collection xxx found:null

## Running Vagrant

    vagrant up --provider vmware_fusion

## Quick Start

Put this in your site.pp file and run sudo puppet apply:

    include solr

If you need multiple cores out of the box, you can run this:

    class { solr:
      cores => [ 'development', 'staging', 'production' ]
    }

It's _**highly**_ recommended that you use a mirror like so:

    class { 'solr':
      mirror        => 'http://apache.mesi.com.ar/lucene/solr',
      version       => '4.10.2',
      cores         => ['development', 'staging', 'production'],
    }

**NOTE**: Currently only Ubuntu is supported, contributions for other platforms are most welcome.
The code is well commented, and should give you a clear idea about how this module configures solr.

##Zookeeper
When searching for the ZK cluster Solr points at:

    localhost:2181

##TODO
- Move the jetty configuration out of the static files and create a template
- The number of node is not dynamic in the jetty file but is set to 1 for now
- ZK presence is out of trust

##License

MIT. Please see the LICENSE file for more information.
