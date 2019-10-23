# Contributing
We welcome error reports, patches and feature requests in the repository. Create a pull request or post an issue at https://github.com/martinaamodt/cockroachdb/issues.

# Running the module
## Puppet module
The latest stable version of the puppet module can be installed by adding this declaration to your Puppetfile:
```Puppet
mod 'neckbeards-cockroachdb', :latest
```

To run from the dev branch, add this declaration to your Puppetfile:
```Puppet
mod 'neckbeards-cockroachdb',
     :git    => 'https://github.com/martinaamodt/cockroachdb.git',
     :branch => 'dev'
```
To test your own branch, replace the git source and branch name with your own.

## Bolt tasks
To install the latest version of the Bolt tasks, add the following declaration to your Bolt Puppetfile:
```Puppet
mod 'neckbeards-cockroachdb', :latest
```
And then run `bolt puppetfile install`.

# Running tests
The repository contains a pre-configured travis-ci file, and all pull requests to dev are run through the pipeline for testing. Tests should pass before we merge your pull request.

If your Github account is linked to travis-ci and you fork the repo, the pipeline will automatically be configured for you. Take a look at the default configuration, and make changes as necessary.

## PDK tests
To run tests locally, you must first install any prerequisites. This can be done by running:
`bundle install` while in the repository. Make sure to have the `bundler` gem install.

To validate syntax, run: `pdk validate`

To run unit tests, run: `pdk test unit`

# Release Process
1. Bump version in metadata.json
2. In clean checkout of dev, run `bundle exec rake changelog`
3. Edit PR titles and tags, until `bundle exec rake changelog` output makes sense.
4. Commit with a tag matching the new version and PR the changes to master
5. After successful review and pipeline run, it will be merged by a code owner.
6. After merge master will be tested, and automagically deployed to Puppet Forge.