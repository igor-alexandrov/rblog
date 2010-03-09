class CreateInternalMessages < ActiveRecord::Migration
  def self.up
    create_table :internal_messages do |t|
      t.integer :sender_id, :null => false
      t.integer :recipient_id, :null => false
      t.datetime :first_time_read_at
      t.datetime :read_at
      t.timestamps
    end
  end

  def self.down
    drop_table :internal_messages
  end
end
