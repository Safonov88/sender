class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :sender_id,             null: false
      t.string :messanger,              null: false
      t.text :body,                     null: false
      t.string :recipient,              null: false
      t.datetime :time_of_the_sending,  null: false
      t.string :status,                 null: false, default: :in_process
      t.integer :number,                null: false, default: 1
      t.integer :number_max,            null: false

      t.timestamps
    end
  end
end
