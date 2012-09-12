class ChangeResultColumnToTextType < ActiveRecord::Migration
  def change
    change_column(:queries, :result, :text)
  end
end
