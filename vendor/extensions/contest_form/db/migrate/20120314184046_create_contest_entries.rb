class CreateContestEntries < ActiveRecord::Migration
  def self.up
    create_table :contest_entries do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :essay_one
      t.text :essay_two
      t.string :blog
      t.string :facebook
      t.string :youtube
      t.string :twitter
      t.string :phone
      t.integer :age
      t.boolean :opt_out

      t.timestamps
    end
  end

  def self.down
    drop_table :contest_entries
  end
end
