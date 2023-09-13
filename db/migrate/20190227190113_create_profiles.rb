class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.text     'addr_line_1',       limit: 65_535
      t.text     'addr_line_2',       limit: 65_535
      t.string   'city'
      t.string   'state'
      t.string   'zip'
      t.string   'phone_number'
      t.datetime 'created_at',                      null: false
      t.datetime 'updated_at',                      null: false
      t.string   'name'
      t.timestamps
    end
  end
end
