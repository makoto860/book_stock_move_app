class AddNoteToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :note, :text
  end
end
