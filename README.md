# carbon_c_relay

[![Puppet Forge](http://img.shields.io/puppetforge/v/mlambrichs/carbon_c_relay.svg)](https://forge.puppetlabs.com/mlambrichs/carbon_c_relay) [![Build Status](https://travis-ci.org/mlambrichs/puppet-carbon_c_relay.svg?branch=master)](https://travis-ci.org/mlambrichs/puppet-carbon_c_relay)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with carbon_c_relay](#setup)
    * [Beginning with carbon_c_relay](#beginning-with-carbon_c_relay)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Contributors - List of contributores to the module](#contributors)

## Overview

The carbon_c_relay puppet module installs, configures and manages a carbon-c-relay instance.

## Module Description

The carbon_c_relay module handles installing, configuring, and running carbon-c-relay.

## Setup

### Beginning with carbon_c_relay

`include '::carbon_c_relay` is enough to get you started. You can pass in parameters like this:

```puppet
class { '::carbon_c_relay':
  service_name => 'relay'
}
```
### Example using Hiera
```
class { '::carbon_c_relay':
  config_clusters             => hiera('carbon_c_relay::config_clusters'),
  config_matches              => hiera('carbon_c_relay::config_matches'),
  config_rewrites             => hiera('carbon_c_relay::config_rewrites'),
  limit_nofile                => hiera('carbon_c_relay::limit_nofile'),
  listen_backlog              => hiera('carbon_c_relay::listen_backlog'),
  package_ensure              => hiera('carbon_c_relay::package_ensure'),
  server_queue_size           => hiera('carbon_c_relay::server_queue_size'),
  statistics_hostname         => $::fqdn,
  statistics_non_cumulative   => hiera('carbon_c_relay::statistics_non_cumulative'),
  statistics_sending_interval => hiera('carbon_c_relay::statistics_sending_interval'),
}
```

YAML
```
---
carbon_c_relay::listen_backlog: 64
carbon_c_relay::limit_nofile: 524288
carbon_c_relay::package_ensure: '2.1-1.el7'
carbon_c_relay::server_queue_size: 10000000
carbon_c_relay::statistics_non_cumulative: true
carbon_c_relay::statistics_sending_interval: 10

carbon_c_relay::config_clusters:
  unmatched:
    comments:
      - 'File cluster to log unmatched metrics'
    channel: 'file'
    destinations:
      - '/var/log/carbon-c-relay/unmatched.log'
  my_cluster:
    comments:
      - 'Default cluster with replication factor of 2'
    channel: 'carbon_ch'
    replication_factor: 2
    destinations:
      - 'relay1:2003 proto tcp'
      - 'relay2:2003'
      - 'relay3:2003'
  anyof_cluster:
    channel: 'anyof'
	useall: true
    destinations:
      - 'relay4:2003 proto tcp'
      - 'relay5:2003=instanceFoo proto udp'
      - 'relay6:2003'

carbon_c_relay::config_rewrites:
  1:
    expression: '(^.*$)'
    replacement: 'foo.\1group.bar'
  2:
    ...

carbon_c_relay::config_matches:
  blacklist:
    comments:
      - 'Send blacklisted metrics to blackhole'
    expressions:
      - '^bad_metric\.'
      - ...
    clusters:
      - 'blackhole'
    stop: true
    order: '02'

  whitelist:
    comments:
      - 'Send whitelisted metrics to my_cluster cluster'
    expressions:
      - '^Good_metric2\.'
      - '^Good_metric2\.'
	  - ...

    clusters:
      - 'my_cluster'
    stop: true
    order: '98'

  unmatched:
    comments:
      - 'Send unmatched metrics to files'
    expressions:
      - '*'
    clusters:
      - 'unmatched'
    stop: true
    order: '99'
```



## Usage

## Reference

To see the inner workings of carbon-c-relay, take a look at
https://github.com/grobian/carbon-c-relay.git

## Limitations

## Development

## Contributors

https://github.com/mlambrichs/puppet-carbon_c_relay/graphs/contributors

