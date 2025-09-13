class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :status, default: "Новая задача", null: false

      t.timestamps
    end
  end
end
