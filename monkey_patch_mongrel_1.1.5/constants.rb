GUARD_MONKEY_PATCH_CONSTANTS=:defined

STARTED_BY_RAKE         = %w[
    rake  rake_test_loader.rb   ].member? $PROGRAM_NAME.split('/').last
STARTED_BY_RUBY_TEST    =         'test'==$PROGRAM_NAME.split('/').first
STARTED_BY_MONKEY_PATCH = 'script/rails'==$PROGRAM_NAME

STARTED_BY_TEST=STARTED_BY_RAKE || STARTED_BY_RUBY_TEST

p Time.now, 'in '+__FILE__ unless STARTED_BY_TEST

STARTED_BY_CPANEL = ! STARTED_BY_TEST && ! STARTED_BY_MONKEY_PATCH
