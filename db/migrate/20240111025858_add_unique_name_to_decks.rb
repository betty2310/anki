class AddUniqueNameToDecks < ActiveRecord::Migration[7.0]
  def change
    add_index :decks, :name, unique: true
  end
end
