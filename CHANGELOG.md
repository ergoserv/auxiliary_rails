# AuxiliaryRails Changelog

## [Unreleased]

### Added

- View helper: `display_name`
- `ErrorsController` template (custom error pages)
- `AuxiliaryRails::Concerns::ServiceConfigurable` added
- Service Module generator

## v0.3.1

### Added
- Errorable concern

### Changed
- Remove validation failed default error #25

## v0.3.0

### Added
- Form Objects
- Query Objects
- Performable concern
- YARD docs and link to API documentation
- Commands usage examples
- Commands: `arguments` helper to get hash of all `param`s

### Changed
- Namespace `Application` instead of `Abstract` prefixes for classes
- Commands migrate from `#call` to `#perform` method
- Commands: force validations

### Removed
- RuboCop generator moved to [rubocop-ergoserv](https://github.com/ergoserv/rubocop-ergoserv) gem

## v0.2.0

* Commands migration to `dry-initializer`

## v0.1.7

* Bundle update (nokogiri 1.10.4, rake 12)

## v0.1.6

* API Resource generator
* Command Object

## v0.1.5

* Fix `Gemfile.lock`

## v0.1.4

* Rename CLI command `create_rails_app` to `new`
* Code style updates in `auxiliary_rails.gemspec`
* Fix order of gems in Rails template, rename template

## v0.1.3

* Upgrade `rubocop` gem and its configs
* `rubocop-rspec` and `rubocop-performance` gem iteration
* Added basic Rails application template
* CLI with `create_rails_app` command

## v0.1.2

* Fix `Gemfile.lock`

## v0.1.1

* View Helpers: `current_controller?` and `current_action?`
* Travis CI, Code Climate integration
* Badges in README.md: gem, build status, maintainability

## v0.1.0

Initial release

* Generators `install_rubocop` and `install_errors`
