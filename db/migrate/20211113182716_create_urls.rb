class CreateUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :urls do |t|
      t.string :url
      t.string :key
      t.integer :counter

      t.timestamps
    end
  end
end
