class CreateList < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :name, required: true
      t.belongs_to :event, index: true, required: true

      t.timestamps
    end
  end
end
