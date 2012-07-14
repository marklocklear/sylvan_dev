set :stages, %w(staging prod dev)
set :default_stage, "staging"
require 'capistrano/ext/multistage'
# require 'capistrano/ext/slicehost'