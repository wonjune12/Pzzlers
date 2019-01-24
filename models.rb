require 'sinatra/activerecord'
require 'pg'

set :database, 'postgresql:blogs'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  database: 'blogs'
)

class User < ActiveRecord::Base
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
end




class CreateUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |user|
      user.string :username
      user.string :password
      user.string :name
      user.string :email
      user.string :dob
      user.datetime :created_timestamp
      user.references :post
    end
  end
end

class CreatePostsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |post|
      post.string :username
      post.string :subject
      post.string :content
      post.datetime :created_timestamp
      post.datetime :updated_timestamp
      post.references :user
    end
  end
  
end


