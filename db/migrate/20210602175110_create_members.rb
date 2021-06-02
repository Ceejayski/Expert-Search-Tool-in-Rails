class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.string :name
      t.text :website
      t.text :short_url
      t.array :headers

      t.timestamps
    end
  end
end
