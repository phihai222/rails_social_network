class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.boolean :twoMFA
      t.boolean :active

      t.timestamps
    end
  end
end
