# egi

## About egi
environment, group, and item

## USAGE

    % cat egi.conf
    env(:development) {
      group(:mysqld) {
        item :vhost0421, { :tags => [ :master ] }
        item :vhost0422
      }

      # you can define item without group
      item :vhost0423, { :tags => [ :rails ] }
    }
    % EGI_ENV=egi irb
    > require 'egi'
    > # find by group or tag
    > Egi.env.mysqld #=> [ { :name => :vhost0421, :tags => [ :mysqld, :master ] },
                           { :name => :vhost0422, :tags => [ :mysqld ] }
                         ]
    > Egi.env.master #=> [ { :name => :vhost0421, :tags => [ :mysqld, :master ] } ]
    > # fetch by name
    > Egi.env.vhost0423 #=> { :name => :vhost0423, :tags => [ :rails ]}, 


## Syntax

### env
T.B.D

### group
not yet implemented

### item
T.B.D

## Aliases

T.B.D
