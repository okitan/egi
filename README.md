# egi [![Build Status](https://secure.travis-ci.org/okitan/egi.png)](http://travis-ci.org/okitan/egi)

tested in ruby 1.8.7, 1.9.2, 1.9.3, and head

## About egi
environment, group, and item

## USAGE

    % cat egi.conf
    env(:development) {
      item :vhost0301, { :tags => [ :mysqld, :rails ] }
    }
    env(:production) {
      group(:mysqld) {
        item :vhost0421, { :tags => [ :master ] }
        item :vhost0422
      }

      # you can define item without group
      item :vhost0423, { :tags => [ :rails ] }
    }
    % EGI_ENV=production irb
    > require 'egi'
    > # find by group or tag
    > Egi.env.mysqld #=> [ { :name => :vhost0421, :tags => [ :mysqld, :master ] },
                           { :name => :vhost0422, :tags => [ :mysqld ] }
                         ]
    > Egi.env.master #=> [ { :name => :vhost0421, :tags => [ :mysqld, :master ] } ]
    > # fetch by name
    > Egi.env.vhost0423 #=> { :name => :vhost0423, :tags => [ :rails ]}, 
    % EGI_ENV=development irb
    > require 'egi'
    > Egi.env.mysqld #=> [ { :name => :vhost0301, :tags => [ :mysqld, :rails ] } ]
    # can not fetch other envs
    > Egi.env.vhost0421 #=> nil

## Syntax

### env
    env(name, &block)
* name
    * the name of env
* &block
    * to define item

### group
tag to the member of the group.

    group(name, &block)
* name
    * the name of group
    * tagged to the member of the group
* &block
    * to define item for the member of the group

### item
    item(name, hash)
* name
    * the name of item
    * if defined the same name, hash will be merged
* hash
    * the property of item
    * :tags
        * you can search by tags

## Aliases

not yet implemented
