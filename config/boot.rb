require 'rubygems'

load File.expand_path '../../monkey_patch_mongrel_1.1.5/constants.rb',
    __FILE__ unless defined? GUARD_MONKEY_PATCH_CONSTANTS

p Time.now, 'in '+__FILE__ unless STARTED_BY_TEST

unless STARTED_BY_TEST

  load File.expand_path '../../monkey_patch_mongrel_1.1.5/boot.rb', __FILE__

else

# Set up gems listed in the Gemfile.
gemfile = File.expand_path('../../Gemfile', __FILE__)
begin
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts "Try running `bundle install`."
  exit!
end if File.exist?(gemfile)

end
