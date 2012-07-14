class AddSeoFieldsToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :page_title, :string, :limit => 70
    add_column :pages, :link_title, :string, :limit => 100
    add_column :pages, :change_frequency, :string
    add_column :pages, :priority, :string, :default => '0.5'
    add_column :pages, :index_for_search, :string, :default => 'yes'
  end

  def self.down
    remove_column :pages, :page_title
    remove_column :pages, :link_title
    remove_column :pages, :change_frequency
    remove_column :pages, :priority
    remove_column :pages, :index_for_search
  end
end
