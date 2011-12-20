p Time.now, 'in '+__FILE__ unless STARTED_BY_TEST

require 'mysql2'

# Moved arel up, because...:
gem 'arel', '=2.0.7'

# Otherwise, got error...:
##   /usr/lib/ruby/site_ruby/1.8/rubygems.rb:274:in `activate': can't activate arel (= 2.0.7, runtime) for [], already activated arel-2.0.8 for ["activerecord-3.0.3"] (Gem::LoadError)

gem 'abstract', '=1.0.0'
gem 'actionmailer', '=3.0.3'
gem 'actionpack', '=3.0.3'
gem 'activemodel', '=3.0.3'
gem 'activerecord', '=3.0.3'
gem 'activeresource', '=3.0.3'
gem 'activesupport', '=3.0.3'
gem 'builder', '=2.1.2'
gem 'erubis', '=2.6.6'
gem 'i18n', '=0.5.0'
gem 'mail', '=2.2.15'
gem 'mime-types', '=1.16'
gem 'polyglot', '=0.3.1'
gem 'rack', '=1.2.1'
gem 'rack-mount', '=0.6.13'
gem 'rack-test', '=0.5.7'
gem 'rails', '=3.0.3'
gem 'railties', '=3.0.3'
gem 'rake', '=0.8.7'
gem 'thor', '=0.14.6'
gem 'treetop', '=1.4.9'
gem 'tzinfo', '=0.3.24'
