require 'data_mapper'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'sqlite:bloggy.db')

class Blog
  include DataMapper::Resource

  property :id, Serial
  property :title, String, required: true, unique: true
  property :content, Text, default: 'Write a blog post!'
  property :created_at, DateTime, required: true

  belongs_to :author, 'User'
end

class User
  include DataMapper::Resource

  property :id, Serial
  property :username, String, required: true, unique: true
  property :password, String, required: true

  has n, :blogs, parent_key: [:id], child_key: [:author_id]
end

DataMapper.finalize
DataMapper.auto_upgrade!
