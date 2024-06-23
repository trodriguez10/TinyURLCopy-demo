class CreateVisits < ActiveRecord::Migration[7.1]
  def change
    create_table :visits do |t|
      t.string :remote_ip, null: false
      t.integer :counter, null: false, default: 1

      t.references :url, null: false, foreign_key: true
      t.timestamps
    end

    add_index :visits, :remote_ip
  end
end
