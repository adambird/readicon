require 'rake'
require 'rspec'
require "#{Rake.application.original_dir}/lib/read_tracker"

include ReadTracker

def random_string
  (0...24).map{ ('a'..'z').to_a[rand(26)] }.join
end

def random_integer
  rand(9999)
end

def random_time
  Time.now - random_integer
end

def random_object_id
  BSON::ObjectId.from_time(random_time).to_s
end