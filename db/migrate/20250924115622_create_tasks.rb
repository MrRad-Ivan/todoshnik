class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.string :status, default: "Новая задача", null: false
      t.date :due_date

      # Поля для повторения задачи
      t.integer :repeat_interval
      t.string :repeat_unit
      t.boolean :repeat_forever, default: false

      t.timestamps
    end
  end
end
