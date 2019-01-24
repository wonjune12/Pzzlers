class Users < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |user|
      user.string :username
      user.string :password
      user.string :name
      user.string :email
      user.string :dob
      user.datetime :created_timestamp
      user.integer :post_counter

    end

  end
end
