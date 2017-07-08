class CreateUsers < Sequel::Migration
  def up
    create_table :users do
      primary_key :id
      column :name, :string
    end
  end

  def down
    drop_table :users
  end
end
