class Posts < ActiveRecord::Migration[5.2]
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
