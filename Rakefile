# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

begin
  require 'annotate'
  Annotate.load_tasks
rescue LoadError, NameError
  # Ignored
end
Rails.application.load_tasks
