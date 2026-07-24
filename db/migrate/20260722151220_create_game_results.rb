class CreateGameResults < ActiveRecord::Migration[8.1]
  def change
    create_table :game_results do |t|
      t.references :user, null: false, foreign_key: true
      t.string :mode, null: false, default: "classic"
      t.date :played_on, null: false
      # Não é FK: personagem é dado versionado em data/characters, não registro de banco.
      t.string :character_id, null: false
      t.integer :attempts, null: false
      t.boolean :won, null: false, default: false

      t.timestamps
    end

    # Uma partida por modo por dia. É isto que impede regravar o resultado para inflar a
    # estatística — não confie no front para isso.
    add_index :game_results, [ :user_id, :mode, :played_on ], unique: true
  end
end
