class AddShortcodeToLinks < ActiveRecord::Migration[6.1]
  def change
    add_column :links, :shortcode, :string
    add_index :links, :shortcode
  end
end
