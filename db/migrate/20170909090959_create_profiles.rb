class CreateProfiles < ActiveRecord::Migration[5.1]
    def change
        create_table :profiles do |t|
            t.string :profile_id
            t.string :from_site
            t.string :location
            t.boolean :messaged, default: false
            t.timestamps
        end
    end
end
