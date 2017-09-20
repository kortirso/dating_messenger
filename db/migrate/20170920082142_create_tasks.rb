class CreateTasks < ActiveRecord::Migration[5.1]
    def change
        create_table :tasks do |t|
            t.string :url
            t.string :email
            t.string :password
            t.text :message
            t.timestamps
        end
        add_column :profiles, :task_id, :integer
        add_index :profiles, :task_id
    end
end
