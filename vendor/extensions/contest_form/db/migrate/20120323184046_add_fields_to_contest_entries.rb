class AddFieldsToContestEntries < ActiveRecord::Migration
  def self.up
    add_column :contest_entries, :address_one, :string
    add_column :contest_entries, :address_two, :string
    add_column :contest_entries, :city, :string
    add_column :contest_entries, :state, :string
    add_column :contest_entries, :zip, :string
    add_column :contest_entries, :gender, :string
    add_column :contest_entries, :how_hear, :text
  end

  def self.down
    remove_column :contest_entries, :address_one
    remove_column :contest_entries, :city
    remove_column :contest_entries, :state
    remove_column :contest_entries, :zip
    remove_column :contest_entries, :gender
    remove_column :contest_entries, :how_hear
  end
end