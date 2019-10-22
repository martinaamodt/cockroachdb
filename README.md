# cockroachdb

[![Build Status](https://travis-ci.com/martinaamodt/cockroachdb.svg?branch=master)](https://travis-ci.com/martinaamodt/cockroachdb)
[![CodeFactor](https://www.codefactor.io/repository/github/martinaamodt/cockroachdb/badge)](https://www.codefactor.io/repository/github/martinaamodt/cockroachdb)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with cockroachdb](#setup)
    * [What cockroachdb affects](#what-cockroachdb-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with cockroachdb](#beginning-with-cockroachdb)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

This is a [CockroachDB](https://www.cockroachlabs.com/product/) module for Puppet. It will help you set up a database cluster
quickly and provides basic functionality for managing it using Bolt tasks. The module is created using PDK for Open Source Puppet and using the Open Source version of CockroachDB.

The module was initially created as part of a project in the subject Infrastructure as Code (IMT3005) at NTNU Gjøvik.

## Setup

### What cockroachdb affects **OPTIONAL**

Dependencies installed by cockroachdb by default:
* tar
* wget
* [puppet-archive](https://forge.puppet.com/puppet/archive) v4.2.0
* [puppetlabs-stdlib](https://forge.puppet.com/puppetlabs/stdlib) >= 4.13.1 < 7.0.0


### Setup Requirements **OPTIONAL**

At the moment the module requires that database nodes are identified by FQDNs, so DNS should be configured prior to use.

To use secure mode, you need to handle the certificates either manually, or using other modules/programs.

### Beginning with cockroachdb

First add the module to your Puppetfile, see the Forge instructions. Then all you need in your manifest to get started is:
```Puppet
class { 'cockroachdb':
  node1ip        => 'db0',
  node2ip        => 'db1',
  node3ip        => 'db2',
}
```
In this example, db0-2 are the DNS hostnames of 3 VMs. These nodes will then get CockroachDB installed, and the service will get started.
To then initialize the database cluster, use:
```
bolt task run cockroachdb -n db0
```
Verify that the cluster is online:
```
bolt task run cockroachdb::node_ls -n db0
```


## Usage

Include usage examples for common use cases in the **Usage** section. Show your users how to use your module to solve problems, and be sure to include code examples. Include three to five examples of the most important or common tasks a user can accomplish with your module. Show users how to accomplish more complex tasks that involve different types, classes, and functions working in tandem.

## Reference

This section is deprecated. Instead, add reference information to your code as Puppet Strings comments, and then use Strings to generate a REFERENCE.md in your module. For details on how to add code comments and generate documentation with Strings, see the Puppet Strings [documentation](https://puppet.com/docs/puppet/latest/puppet_strings.html) and [style guide](https://puppet.com/docs/puppet/latest/puppet_strings_style.html)

If you aren't ready to use Strings yet, manually create a REFERENCE.md in the root of your module directory and list out each of your module's classes, defined types, facts, functions, Puppet tasks, task plans, and resource types and providers, along with the parameters for each.

For each element (class, defined type, function, and so on), list:

  * The data type, if applicable.
  * A description of what the element does.
  * Valid values, if the data type doesn't make it obvious.
  * Default value, if any.

For example:

```
### `pet::cat`

#### Parameters

##### `meow`

Enables vocalization in your cat. Valid options: 'string'.

Default: 'medium-loud'.
```

## Limitations

In the Limitations section, list any incompatibilities, known issues, or other warnings.

## Development

In the Development section, tell other users the ground rules for contributing to your project and how they should submit their work.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You can also add any additional sections you feel are necessary or important to include here. Please use the `## ` header.
