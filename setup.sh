#! /bin/bash

export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

gem install cocoapods --user-install
gem which cocoapods
/Users/epita/.gem/ruby/2.0.0/gems/cocoapods-0.29.0/lib/cocoapods.rb
/Users/eloy/.gem/ruby/2.0.0/bin/pod install

