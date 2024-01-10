class AddNicknameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nickname, :string,unique: true, null: false, default: ''
    add_index :users, :nickname, unique: true
  end
end
