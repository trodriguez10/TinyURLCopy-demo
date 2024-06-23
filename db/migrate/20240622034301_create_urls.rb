class CreateUrls < ActiveRecord::Migration[7.1]
  def change
    create_table :urls do |t|
      t.string :long_url, null: false
      t.string :token, null: false

      t.timestamps
    end

    add_index :urls, :token, unique: true
  end
end
