class CreatePresence < ActiveRecord::Migration[5.2]
  def change
    create_table :presences do |t|
      t.string :name, required: true
      t.datetime :date, required: true
      t.belongs_to :list, index: true, required: true

      t.timestamps
    end
  end
end
