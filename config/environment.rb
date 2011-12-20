load File.expand_path '../../monkey_patch_mongrel_1.1.5/constants.rb',
    __FILE__ unless defined? GUARD_MONKEY_PATCH_CONSTANTS

p Time.now, 'in '+__FILE__ unless STARTED_BY_TEST

if STARTED_BY_CPANEL

  load File.expand_path '../../monkey_patch_mongrel_1.1.5/start_webrick.rb', __FILE__

else

# Load the rails application

require File.expand_path('../application', __FILE__)

# Initialize the rails application
Gallery::Application.initialize!

end
