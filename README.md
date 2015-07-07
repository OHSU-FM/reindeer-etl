[![Gem Version](https://badge.fury.io/rb/reindeer-etl.svg)](http://badge.fury.io/rb/reindeer-etl)
[![License](https://img.shields.io/badge/license-GPL-blue.svg)](License.md)
[![Downloads](https://img.shields.io/gem/dt/reindeer_etl.svg)]

# ReindeerETL

Sources, Transforms and Destinations for the [Kiba](https://github.com/thbar/kiba) ETL gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'reindeer-etl'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install reindeer-etl

## Usage

### Simple Example

If you have a csv file that looks like this:

input.csv

```
a,b,c
1,2,3
4,5,6
```

In your kiba ETL script you can now do this:


```ruby
require 'reindeer-etl'

only_fields = ['a', 'b']

# Open a csv file
source(ReindeerETL::Sources::CSVSource, './input.csv', 
    require: only_fields, only: only_fields)

# rename a column
transform(ReindeerETL::Transforms::RenameFields, {'b'=>'c'}

# Recode all 777 values as 888
transform ReindeerETL::Transforms::Recode, cols: ['a'],
    codes: {'777'=>'888'}, ignore_all: true

# Write the file to disk
destination ReindeerETL::Destinations::CSVDest, './output.csv'
```

### Joining data from multiple sources

A slightly more complex example is where you have data in multiple CSV files and 
you would like to join that information into a single ETL job.

input1.csv
```
a,b,c
1,2,3
4,5,6
```

input2.csv
```
a,e,f
1,7,8
4,10,11
```

reindeer.etl
```ruby
# Open a csv file
source(ReindeerETL::Sources::MultiSource, ['./input1.csv', './input2.csv'], key: 'a')

# Write the file to disk
destination ReindeerETL::Destinations::CSVDest, './output.csv'

```

output.csv
```
a,b,c,e,f
1,2,3,7,8
4,5,6,10,11
```

### More examples coming soon

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/reindeer-etl/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
