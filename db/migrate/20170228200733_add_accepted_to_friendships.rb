class AddAcceptedToFriendships < ActiveRecord::Migration[5.0]
  def change
  	add_column :friendships, :accepted, :boolean, default: false
  end
end
