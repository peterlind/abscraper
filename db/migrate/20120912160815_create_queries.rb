class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :input
      t.string :result
      t.string :remote_ip
      t.string :user_agent

      t.timestamps
    end
  end
end
