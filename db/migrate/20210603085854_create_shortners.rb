class CreateShortners < ActiveRecord::Migration[6.1]
  def change
    create_table :shortners do |t|
      t.text :short_url
      t.text :headers, default: [].to_yaml
      t.references :member, null: false, foreign_key: true

      t.timestamps
    end
  end
end
