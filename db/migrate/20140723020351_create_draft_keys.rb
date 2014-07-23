class CreateDraftKeys < ActiveRecord::Migration
  def change
    create_table :draft_keys do |t|

      t.timestamps
    end
  end
end
