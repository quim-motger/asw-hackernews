class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.string :contr_type
      t.string :contr_subtype
      t.text :content
      t.references :user, index: true, foreign_key: true
      t.string :url
      t.integer :upvote
      t.references :parent, index: true

      t.timestamps null: false
    end
  end
end
