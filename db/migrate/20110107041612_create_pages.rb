class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.string :content
      t.boolean :trash, {:default => false}

      t.timestamps
    end
    Page.create({:title => "Home", :content => "Welcome to your new site!"})
  end

  def self.down
    drop_table :pages
  end
end
