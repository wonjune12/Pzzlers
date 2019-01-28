require 'sinatra/activerecord'
require 'pg'

set :database, 'postgresql:blogs'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'blogs'
  
)

class User < ActiveRecord::Base
  has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
end




