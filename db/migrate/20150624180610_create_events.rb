class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :ticket_cost

      t.timestamps
    end
  end
end
