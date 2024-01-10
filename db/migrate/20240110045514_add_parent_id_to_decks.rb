class AddParentIdToDecks < ActiveRecord::Migration[7.0]
  def change
    add_reference :decks, :parent, foreign_key: { to_table: :decks }
  end
end
