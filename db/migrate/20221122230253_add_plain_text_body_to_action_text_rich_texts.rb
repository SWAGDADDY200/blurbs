class AddPlainTextBodyToActionTextRichTexts < ActiveRecord::Migration[7.0]
  def change
    add_column :action_text_rich_texts, :/, :string
    add_column :action_text_rich_texts, :plain_text_body, :text
  end
end
