require 'dm-timestamps'

class Post

  # this makes the instances of this class Datamapper resources
  include DataMapper::Resource

  property :id, Serial
  property :created_at, Time
  property :message, String, :length => 1..141

end