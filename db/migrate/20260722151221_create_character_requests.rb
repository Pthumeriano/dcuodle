class CreateCharacterRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :character_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.text :notes
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
