# cockroachdb

[![Build Status](https://travis-ci.com/martinaamodt/cockroachdb.svg?branch=master)](https://travis-ci.com/martinaamodt/cockroachdb)
[![CodeFactor](https://www.codefactor.io/repository/github/martinaamodt/cockroachdb/badge)](https://www.codefactor.io/repository/github/martinaamodt/cockroachdb)

#### Table of Contents

1. [Description](#description)
2. [Setup - Getting started with cockroachdb](#setup)
    * [What cockroachdb affects](#what-cockroachdb-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with cockroachdb](#beginning-with-cockroachdb)
3. [Example Usage](#usage)
4. [Limitations and Known Issues](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

This is a [CockroachDB](https://www.cockroachlabs.com/product/) module for Puppet. It will help you set up a database cluster
quickly and provides basic functionality for managing it using Bolt tasks. The module is created using PDK for Open Source Puppet and using the Open Source version of CockroachDB.

The module was initially created as part of a project in the subject Infrastructure as Code (IMT3005) at NTNU Gjøvik.

## Setup

### What cockroachdb affects

Dependencies installed by cockroachdb by default:
* tar
* wget
* [puppet-archive](https://forge.puppet.com/puppet/archive) v4.2.0
* [puppetlabs-stdlib](https://forge.puppet.com/puppetlabs/stdlib) >= 4.13.1 < 7.0.0


### Setup Requirements

At the moment the module requires that database nodes are identified by FQDNs, so DNS should be configured prior to use.

To use secure mode, you need to handle the certificates either manually, or using other modules/programs. 

### Beginning with cockroachdb

First add the module to your Puppetfile, see the Forge instructions. Then all you need in your manifest to get started is:

**Insecure mode**
```Puppet
class { 'cockroachdb':
  node1ip     => 'db0',
  node2ip     => 'db1',
  node3ip     => 'db2',
  secure_mode => false,
}
``` 
**Secure mode**
```Puppet
class { 'cockroachdb':
  node1ip     => 'db0',
  node2ip     => 'db1',
  node3ip     => 'db2',
  secure_mode => true,
  certs_dir   => '/root/certs',
}
```

## Usage
**Specifying different cockroachdb version:**
```Puppet
class { 'cockroachdb':
  node1ip        => 'db0',
  node2ip        => 'db1',
  node3ip        => 'db2',
  package_ensure => 'v19.1.0.linux-amd64',
  secure_mode    => false,
}
```

**Adding additional parameters to cockroachdb that are not directly supported in the module:**
```Puppet
class { 'cockroachdb':
  node1ip           => 'db0',
  node2ip           => 'db1',
  node3ip           => 'db2',
  secure_mode       => false,
  additional_params => '--store=/mnt/ssd01',
}
```

**Initializing a cluster using bolt tasks:**

To then initialize the database cluster, use:
```
bolt task run cockroachdb -n db0 insecure=true
```
Verify that the cluster is online:
```
bolt task run cockroachdb::node_ls -n db0 insecure=true
```

## Limitations
**Limitations:**
* Only a three node initial cluster is supported. But still works with more nodes joining later
* Can not switch from secure to insecure mode

**Known Issues:**

**Warnings:**


## Development
[Contribution guidelines for this project](CONTRIBUTING.md)

## Changelog
[Changelog](CHANGELOG.md)
