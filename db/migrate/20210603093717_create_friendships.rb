class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.references :friend, null: false
      t.references :person, null: false


      t.timestamps
    end
  end
end
