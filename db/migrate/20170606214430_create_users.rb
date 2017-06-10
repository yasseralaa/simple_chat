class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string "username", :limit => 40
      t.string "password", :limit => 40
      t.timestamps
    end
  end

  def down
    drop_table :users
  end

end
