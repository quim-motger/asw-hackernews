class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.string :contr_type
      t.string :contr_subtype
      t.text :content
      t.string :url
      t.integer :upvote
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
